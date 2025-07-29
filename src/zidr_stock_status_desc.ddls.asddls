@AbapCatalog.sqlViewName: 'ZIDR_STOCK_STAT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Status Description Entity'
define view zidr_stock_status_desc as select from zdr_stock_status as Status
{
    @UI.textArrangement: #TEXT_ONLY
    @ObjectModel.text.element:[ 'StockStatusText' ] 
    key stock_status_id as StockStatusId,
    @UI.hidden: true
    stock_status_text as StockStatusText
}
