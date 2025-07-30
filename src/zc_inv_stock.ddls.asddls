@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.sapObjectNodeType.name: 'ZINV_STOCK'
define root view entity ZC_INV_STOCK
  provider contract transactional_query
  as projection on ZDR_R_INV_STOCK
{
  key MaterialId,
  key PlantId,
  key StorageLocation,
  
    // Material Info
  MaterialType,
  MaterialGroup,
  MaterialDesc,
  MaterialGroupDesc,
  MaterialTypeDesc,
  ValuationClass,
  StandardPrice,
  @Semantics.currencyCode: true
  PriceUnit,
  GrossWeight,
  NetWeight,
  @Semantics.unitOfMeasure: true
  WeightUnit,
  Volume,
  @Semantics.unitOfMeasure: true
  VolumeUnit,
  
  // Plant Info
  _Plant.PlantName,
  _Plant.City as PlantCity,
  _Plant.Country as PlantCountry,
  _Plant.Region as PlantRegion,
  _Plant.PlantAddress,
  _Plant.PlantCategory,
  _Plant.PlantTimezone,
  _Plant.PhoneNumber as PlantPhoneNumber,
  
  // Storage Location
  _StorageLoc.StorageDesc,

  // Quantities
  CurrentStock,
  MinimumStock,
  MaximumStock,
  ReorderPoint,
  SafetyStock,
  UnrestrictedStock,
  QualityStock,
  BlockedStock,
  ReservedStock,
  InTransitStock,
  @Semantics.unitOfMeasure: true
  UnitOfMeasure,

  _StockStatusDesc.StockStatusText as StockStatusText,
  @ObjectModel.text.element: ['StockStatusText']
  StockStatus,
  DaysOfStock,
  
  @Semantics.currencyCode: true
  Currency,
  StockValue,
  
  // Movement History
  LastGoodsReceipt,
  LastGoodsIssue,
  LastMovementType,
  LastMovementDate,
  StockType,
  
  CreatedBy,
  CreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,
 
  _Material,
  _Plant,
  _StorageLoc,
  _PurInfo,
  _StockStatusDesc,
  _PurchReq,
  _StockMovements
  
}
