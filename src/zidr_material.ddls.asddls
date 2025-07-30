@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZIDR_Material as select from zdr_material
{
    key material_id as MaterialId,
    material_type as MaterialType,
    material_group as MaterialGroup,
    material_desc as MaterialDesc,
    material_group_desc as MaterialGroupDesc,
    material_type_desc as MaterialTypeDesc,
    valuation_class as ValuationClass,
    @Semantics.amount.currencyCode : 'PriceUnit'
    standard_price as StandardPrice,
    price_unit as PriceUnit,
    valuation_uom as ValuationUom,
    @Semantics.quantity.unitOfMeasure : 'WeightUnit'
    gross_weight as GrossWeight,
    @Semantics.quantity.unitOfMeasure : 'WeightUnit'
    net_weight as NetWeight,
    weight_unit as WeightUnit,
    @Semantics.quantity.unitOfMeasure : 'VolumeUnit'
    volume as Volume,
    volume_unit as VolumeUnit,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
