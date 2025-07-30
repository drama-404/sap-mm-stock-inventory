@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requisitions Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity zidr_purch_req as select from zdr_purch_req
association [1] to ZIDR_Material as _Material on $projection.MaterialId = _Material.MaterialId
association [1] to zidr_supplier as _Supplier on $projection.SupplierId = _Supplier.SupplierId
association [1] to ZIDR_plant as _Plant on $projection.PlantId = _Plant.Plant
{
    key pr_number as PrNumber,
    key material_id as MaterialId,
    key plant_id as PlantId,
    key supplier_id as SupplierId,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    quantity as Quantity,
    unit_of_measure as UnitOfMeasure,
    requester as Requester,
    status as Status,
    created_on as CreatedOn,
    delivery_date as DeliveryDate,
    note as Note,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    
    /* Associations */
    _Material,
    _Plant,
    _Supplier
}
