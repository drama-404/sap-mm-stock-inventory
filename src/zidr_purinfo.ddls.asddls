@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Info Records Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity zidr_purinfo as select from zdr_purinfo
association [1] to ZIDR_Material as _Material on $projection.MaterialId = _Material.MaterialId
association [1] to zidr_supplier as _Supplier on $projection.SupplierId = _Supplier.SupplierId
association [1] to ZIDR_plant as _Plant on $projection.PlantId = _Plant.Plant
{
    key material_id as MaterialId,
    key supplier_id as SupplierId,
    key plant_id as PlantId,
    @Semantics.amount.currencyCode: 'PriceUnit'
    net_price as NetPrice,
    price_unit as PriceUnit,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    minimum_order_qty as MinimumOrderQty,
    unit_of_measure as UnitOfMeasure,
    delivery_time as DeliveryTime,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    vendor_material_no as VendorMaterialNo,
    incoterms1 as Incoterms1,
    incoterms2 as Incoterms2,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    
    /* Associations */
    _Material,
    _Supplier,
    _Plant
}
