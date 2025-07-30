@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Inventory Stock - Core BO Entity'
@ObjectModel.sapObjectNodeType.name: 'ZINV_STOCK'
define root view entity ZDR_R_INV_STOCK
  as select from zadr_inv_stock as StockInventory
association [1] to ZIDR_Material           as _Material on $projection.MaterialId = _Material.MaterialId
association [1] to ZIDR_plant              as _Plant on $projection.PlantId = _Plant.Plant
association [0..1] to ZIDR_Storage_loc     as _StorageLoc on  $projection.PlantId = _StorageLoc.Plant
                                                              and $projection.StorageLocation = _StorageLoc.StorageLocation
association [0..*] to zidr_purinfo         as _PurInfo on  $projection.MaterialId = _PurInfo.MaterialId
                                                       and $projection.PlantId    = _PurInfo.PlantId
association [0..1] to zidr_stock_status_desc    as _StockStatusDesc on $projection.StockStatus = _StockStatusDesc.StockStatusId
association [0..*] to zidr_purch_req as _PurchReq on $projection.MaterialId = _PurchReq.MaterialId
                                                    and $projection.PlantId    = _PurchReq.PlantId
association [0..*] to zidr_stock_mov as _StockMovements on $projection.MaterialId = _StockMovements.MaterialId
                                                        and $projection.PlantId   = _StockMovements.PlantId
{
  key material_id as MaterialId,
  key plant_id as PlantId,
  key storage_location as StorageLocation,
  
  // Material Info
  _Material.MaterialType,
  _Material.MaterialGroup,
  _Material.MaterialDesc,
  _Material.MaterialGroupDesc,
  _Material.MaterialTypeDesc,
  _Material.ValuationClass,
  @Semantics.amount.currencyCode: 'PriceUnit'
  _Material.StandardPrice,
  _Material.PriceUnit,
  @Semantics.quantity.unitOfMeasure: 'WeightUnit'
  _Material.GrossWeight,
  @Semantics.quantity.unitOfMeasure: 'WeightUnit'
  _Material.NetWeight,
  _Material.WeightUnit,
  @Semantics.quantity.unitOfMeasure: 'VolumeUnit'
  _Material.Volume,
  _Material.VolumeUnit,
  
  // Plant Info
  _Plant.PlantName,
  _Plant.City as PlantCity,
  _Plant.Country as PlantCountry,
  _Plant.Region as PlantRegion,
  _Plant.PlantAddress,
  _Plant.PlantCategory,
  _Plant.PlantTimezone,
  _Plant.PhoneNumber as PlantPhoneNumber,
  
  // Storage Location
  _StorageLoc.StorageDesc,
  
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_UnitOfMeasureStdVH', 
    entity.element: 'UnitOfMeasure', 
    useForValidation: true
  } ]
  unit_of_measure as UnitOfMeasure,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  current_stock as CurrentStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  minimum_stock as MinimumStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  maximum_stock as MaximumStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  reorder_point as ReorderPoint,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  safety_stock as SafetyStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  unrestricted_stock as UnrestrictedStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  quality_stock as QualityStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  blocked_stock as BlockedStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  reserved_stock as ReservedStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  in_transit_stock as InTransitStock,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  open_pr_qty as OpenPrQty,
  @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
  open_po_qty as OpenPoQty,
  stock_type as StockType,
  last_goods_receipt as LastGoodsReceipt,
  last_goods_issue as LastGoodsIssue,
  last_movement_type as LastMovementType,
  last_movement_date as LastMovementDate,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  @Semantics.amount.currencyCode: 'Currency'
  stock_value as StockValue,
  
  // Calculated fields
  case
    when StockInventory.current_stock <= StockInventory.reorder_point then cast(1 as abap.int4)
    when StockInventory.current_stock <= cast(
          cast(StockInventory.reorder_point as abap.dec(15,3)) * cast(1.2 as abap.dec(3,1))
          as abap.quan(13,3)) then cast(2 as abap.int4)
    else cast(3 as abap.int4)
  end as StockStatus,

  case
    when StockInventory.current_stock > cast(0 as abap.quan(13,3))
    then cast(
           division(
             cast(StockInventory.current_stock as abap.dec(15,3)),
             case
               when dats_days_between(StockInventory.last_goods_issue, $session.system_date) > 0
               then cast(dats_days_between(StockInventory.last_goods_issue, $session.system_date) as abap.dec(15,3))
               else cast(30 as abap.dec(15,3))
             end,
             1)
           as abap.dec(10,1))
    else cast(0 as abap.dec(10,1))
  end as DaysOfStock,
  
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
  
    // Associations
  _Material,
  _Plant,
  _StorageLoc,
  _PurInfo,
  _StockStatusDesc,
  _PurchReq,
  _StockMovements
  
}
