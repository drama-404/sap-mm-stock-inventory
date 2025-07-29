@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zidr_material as select from zdr_material
{
    key material as Material,
    material_type as MaterialType,
    material_group as MaterialGroup,
    material_desc as MaterialDesc,
    base_unit_of_measure as BaseUnitOfMeasure,
    material_status as MaterialStatus,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
