@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@ObjectModel.sapObjectNodeType.name: 'ZADR_INV_STOCK'
define root view entity ZRDR_INV_STOCK
  as select from zadr_inv_stock as Stock
  association [0..1] to zidr_material as _Material on $projection.MaterialId = _Material.Material
  association [0..1] to ZIDR_plant as _Plant on $projection.PlantId = _Plant.Plant
  association [0..*] to zidr_purinfo   as _PurInfo   on $projection.MaterialId = _PurInfo.MaterialId
                                                  and $projection.PlantId = _PurInfo.PlantId
  association [0..1] to zidr_stock_status_desc as _StockStatusDesc on $projection.StockStatus = _StockStatusDesc.StockStatusId      
{     
  key Stock.material_id as MaterialId,
  key Stock.plant_id as PlantId,
  
        // Material Information
      _Material.MaterialDesc              as MaterialDescription,
      _Material.MaterialType              as MaterialType,
      _Material.MaterialGroup             as MaterialGroup,

      // Plant Information
      _Plant.PlantName                    as PlantName,
      _Plant.Country                      as Country,
  
  
  //Stock Information
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH', 
    entity.element: 'UnitOfMeasure', 
    useForValidation: true
  } ]
  Stock.unit_of_measure as UnitOfMeasure,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  Stock.current_stock as CurrentStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  Stock.minimum_stock as MinimumStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  Stock.maximum_stock as MaximumStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  Stock.reorder_point as ReorderPoint,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  Stock.safety_stock as SafetyStock,
    @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  Stock.currency as Currency,
  @Semantics.amount.currencyCode: 'Currency'
  Stock.stock_value as StockValue,
  
  Stock.last_goods_receipt as LastGoodsReceipt,
  Stock.last_goods_issue as LastGoodsIssue,
  
        // Calculated Business Logic
      case 
        when Stock.current_stock <= Stock.reorder_point
        then cast(1 as abap.int4)  // Critical - Red
        when Stock.current_stock <= cast(
               cast(Stock.reorder_point as abap.dec(15,3)) * cast(1.2 as abap.dec(3,1))
               as abap.quan(13,3))
        then cast(2 as abap.int4)  // Warning - Yellow  
        else cast(3 as abap.int4)  // OK - Green
      end                                 as StockStatus,
      
      case
        when Stock.current_stock > cast(0 as abap.quan(13,3))
        then cast(
               division(
                 cast(Stock.current_stock as abap.dec(15,3)), 
                 // Estimated daily consumption: current stock / days since last issue
                 case 
                   when dats_days_between(Stock.last_goods_issue, $session.system_date) > 0
                   then cast(dats_days_between(Stock.last_goods_issue, $session.system_date) as abap.dec(15,3))
                   else cast(30 as abap.dec(15,3))  // Default: 30 days if no recent issues
                 end, 
                 1)
               as abap.dec(10,1))
        else cast(0 as abap.dec(10,1))
      end                                 as DaysOfStock,
  
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  
  /* Associations */
  _Material,
  _Plant,
  _PurInfo,
  _StockStatusDesc
  
}

