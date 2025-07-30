@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Storage Location Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIDR_Storage_loc as select from zdr_storage_loc
association [1] to ZIDR_plant as _Plant on $projection.Plant = _Plant.Plant
{
    key plant as Plant,
    key storage_location as StorageLocation,
    storage_desc as StorageDesc,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    
    /* Associations */
    _Plant
}
