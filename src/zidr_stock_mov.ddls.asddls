@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Movements Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity zidr_stock_mov as select from zdr_stock_mov
association [1] to ZIDR_Material as _Material on $projection.MaterialId = _Material.MaterialId
association [1] to ZIDR_plant as _Plant on $projection.PlantId = _Plant.Plant
association [1] to ZIDR_Storage_loc as _StorageLoc on $projection.StorageLocation = _StorageLoc.StorageLocation
                                                  and $projection.PlantId = _StorageLoc.Plant
{
    key movement_id as MovementId,
    key material_id as MaterialId,
    key plant_id as PlantId,
    key storage_location as StorageLocation,
    movement_type as MovementType,
    movement_reason as MovementReason,
    posting_date as PostingDate,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    quantity as Quantity,
    unit_of_measure as UnitOfMeasure,
    stock_type as StockType,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    stock_before as StockBefore,
    @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
    stock_after as StockAfter,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    
    /* Associations */
    _Material,
    _Plant,
    _StorageLoc
}
