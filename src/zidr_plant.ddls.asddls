@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant/Store Master Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIDR_plant as select from zdr_plant
association [0..*] to ZIDR_Storage_loc as _StorageLocations on $projection.Plant = _StorageLocations.Plant
{
    key plant as Plant,
    plant_name as PlantName,
    city as City,
    country as Country,
    region as Region,
    plant_address as PlantAddress,
    plant_category as PlantCategory,
    plant_timezone as PlantTimezone,
    phone_number as PhoneNumber,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    
    /* Associations */
    _StorageLocations
}
