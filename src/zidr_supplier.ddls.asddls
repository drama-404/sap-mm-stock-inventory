@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Master Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity zidr_supplier as select from zdr_supplier
{
    key supplier_id as SupplierId,
    supplier_name as SupplierName,
    supplier_group as SupplierGroup,
    country as Country,
    phone_number as PhoneNumber,
    email_address as EmailAddress,
    tax_number as TaxNumber,
    payment_terms as PaymentTerms,
    lead_time_days as LeadTimeDays,
    is_preferred as IsPreferred,
    created_by as CreatedBy,
    created_at as CreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
