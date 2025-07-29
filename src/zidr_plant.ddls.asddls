@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Plant/Store Master Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZIDR_plant as select from zdr_plant
{
    key plant as Plant,
    plant_name as PlantName,
    city as City,
    country as Country,
    region as Region,
    plant_type as PlantType,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
