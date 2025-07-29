@Metadata.allowExtensions: true
@EndUserText.label: 'Retail Inv. Management'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.sapObjectNodeType.name: 'ZADR_INV_STOCK'
define root view entity ZCDR_INV_STOCK
  provider contract transactional_query
  as projection on ZRDR_INV_STOCK
{
  key MaterialId,
  key PlantId,
  
  // Material
  MaterialDescription,
  MaterialGroup,
  MaterialType,
  
  //Plant
  PlantName,
  Country,
  
  // Stock
  @Semantics.unitOfMeasure: true
  UnitOfMeasure,
  CurrentStock,
  MinimumStock,
  MaximumStock,
  ReorderPoint,
  SafetyStock,
  _StockStatusDesc.StockStatusText as StockStatusText,
  @ObjectModel.text.element: ['StockStatusText']
  StockStatus,
  DaysOfStock,
  LastGoodsReceipt,
  LastGoodsIssue,
  @Semantics.currencyCode: true
  Currency,
  StockValue,
  CreatedBy,
  CreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
  
  _Material,
  _Plant,
  _PurInfo,
  _StockStatusDesc
  
}
