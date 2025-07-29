@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Info Records Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zidr_purinfo as select from zdr_purinfo
{
    key material_id as MaterialId,
    key supplier_id as SupplierId,
    key plant_id as PlantId,
    @Semantics.amount.currencyCode: 'Currency'
    net_price as NetPrice,
    currency as Currency,
    unit_of_measure as UnitOfMeasure,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    price_unit as PriceUnit,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    minimum_order_qty as MinimumOrderQty,
    delivery_time as DeliveryTime,
    valid_from as ValidFrom,
    valid_to as ValidTo,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
