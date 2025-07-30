*CLASS lcl_upload_data DEFINITION.
*
*  PUBLIC SECTION.
*    METHODS:
*      upload,
*      delete_data.
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*
*    CONSTANTS:
*      lc_client TYPE mandt VALUE '001',
*      lc_user   TYPE syuname VALUE ' DEMOUSER'.
*
*    DATA:
*      lv_today_long TYPE utclong.
*
*    METHODS:
*      fill_materials,
*      fill_plants,
*      fill_stocks,
*      fill_purinfos,
*      fill_stock_status_desc.
*
*ENDCLASS.
*
*CLASS lcl_upload_data IMPLEMENTATION.
*
*  "-------------------------------------------------------------------------------
*  " Fill Materials
*  "------------------------------------------------------------------------
*  METHOD fill_materials.
*    DATA: lt_material TYPE STANDARD TABLE OF zdr_material.
*    DATA(lv_today_long) = utclong_current( ).
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'LAPTOP001'
*                    material_type            = 'LPTP'
*                    material_group           = 'ELEC'
*                    material_desc            = 'Business Laptop 14in'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01'
**                    created_by               = lc_user
**                    created_at               =
**                    local_last_changed_by    = lc_user
**                    local_last_changed_at    = lv_today_long
**                    last_changed_at          = lv_today_long
*                    ) TO lt_material.
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'LAPTOP002'
*                    material_type            = 'LPTP'
*                    material_group           = 'ELEC'
*                    material_desc            = 'GamingLaptop 15in'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01' ) TO lt_material.
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'LAPTOP002'
*                    material_type            = 'LPTP'
*                    material_group           = 'ELEC'
*                    material_desc            = 'Gaming Laptop 15in'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01' ) TO lt_material.
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'MONITOR01'
*                    material_type            = 'MNTR'
*                    material_group           = 'ELEC'
*                    material_desc            = 'Monitor 24in'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01' ) TO lt_material.
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'MOUSE001'
*                    material_type            = 'ACCS'
*                    material_group           = 'ELEC'
*                    material_desc            = 'Wireless Mouse'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01' ) TO lt_material.
*
*    APPEND VALUE #( client                   = lc_client
*                    material                 = 'KEYBD001'
*                    material_type            = 'ACCS'
*                    material_group           = 'ELEC'
*                    material_desc            = 'Mechanical Keyboard'
*                    base_unit_of_measure     = 'EA'
*                    material_status          = '01' ) TO lt_material.
*
*
*    DELETE FROM zdr_material.
*    INSERT zdr_material FROM TABLE @lt_material
*      ACCEPTING DUPLICATE KEYS.
*    COMMIT WORK.
*
*  ENDMETHOD.
*  "-------------------------------------------------------------------------------
*  " Fill Plants
*  "------------------------------------------------------------------------
*  METHOD fill_plants.
*    DATA lt_plant TYPE STANDARD TABLE OF zdr_plant.
*
*    APPEND VALUE #( client                = lc_client
*                    plant                 = 'DE01'
*                    plant_name            = 'Berlin Store'
*                    city                  = 'Berlin'
*                    country               = 'DE'
*                    region                = 'BE'
*                    plant_type            = 'ST' ) TO lt_plant.
*
*    APPEND VALUE #( client                = lc_client
*                    plant                 = 'FR01'
*                    plant_name            = 'Paris Store'
*                    city                  = 'Paris'
*                    country               = 'FR'
*                    region                = 'IDF'
*                    plant_type        = 'ST' ) TO lt_plant.
*
*    APPEND VALUE #( client                = lc_client
*                    plant                 = 'IT01'
*                    plant_name            = 'Milan Store'
*                    city                  = 'Milan'
*                    country               = 'IT'
*                    region                = 'LOM'
*                    plant_type        = 'ST' ) TO lt_plant.
*
*    DELETE FROM zdr_plant.
*    INSERT zdr_plant FROM TABLE @lt_plant
*      ACCEPTING DUPLICATE KEYS.
*    COMMIT WORK.
*
*  ENDMETHOD.
*  "-------------------------------------------------------------------------------
*  " Fill Stocks
*  "------------------------------------------------------------------------
*  METHOD fill_stocks.
*    DATA lt_stock TYPE STANDARD TABLE OF zadr_inv_stock.
*
*    CONSTANTS: lc_today TYPE d VALUE '20250722',
*               lc_date1 TYPE d VALUE '20250701',
*               lc_date2 TYPE d VALUE '20250615'.
*
*    APPEND VALUE #( client                = lc_client
*                    material_id           = 'LAPTOP001'
*                    plant_id              = 'DE01'
*                    unit_of_measure = 'EA'
*                    current_stock             = 87
*                    minimum_stock         = 20
*                    maximum_stock         = 150
*                    reorder_point         = 80
*                    safety_stock      = 10
*                    last_goods_issue   = lc_date1
*                    last_goods_receipt     = lc_date2
*                    currency              = 'EUR'
*                    stock_value         = '739.94' ) TO lt_stock.
*
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'LAPTOP002'
*                    plant_id                 = 'FR01'
*                    unit_of_measure  = 'EA'
*                    current_stock             = 15
*                    minimum_stock         = 20
*                    maximum_stock         = 150
*                    reorder_point         = 25
*                    safety_stock      = 10
*                    last_goods_issue   = lc_date1
*                    last_goods_receipt     = lc_date2
*                    currency              = 'EUR'
*                    stock_value         = '1199.49' ) TO lt_stock.
*
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'MONITOR01'
*                    plant_id                 = 'IT01'
*                    unit_of_measure  = 'EA'
*                    current_stock             = 112
*                    minimum_stock         = 20
*                    maximum_stock         = 150
*                    reorder_point         = 60
*                    safety_stock      = 10
*                    last_goods_issue   = lc_date1
*                    last_goods_receipt    = lc_date2
*                    currency              = 'EUR'
*                    stock_value         = '204.99' ) TO lt_stock.
*
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'MOUSE001'
*                    plant_id                 = 'DE01'
*                    unit_of_measure  = 'EA'
*                    current_stock             = 5
*                    minimum_stock         = 20
*                    maximum_stock         = 150
*                    reorder_point         = 15
*                    safety_stock      = 10
*                    last_goods_issue   = lc_date1
*                    last_goods_receipt    = lc_date2
*                    currency              = 'EUR'
*                    stock_value         = '29.99' ) TO lt_stock.
*
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'KEYBD001'
*                    plant_id                 = 'FR01'
*                    unit_of_measure  = 'EA'
*                    current_stock             = 52
*                    minimum_stock         = 20
*                    maximum_stock         = 150
*                    reorder_point         = 40
*                    safety_stock      = 10
*                    last_goods_issue   = lc_date1
*                    last_goods_receipt    = lc_date2
*                    currency              = 'EUR'
*                    stock_value        = '79.99' ) TO lt_stock.
*
*    DELETE FROM zadr_inv_stock.
*    INSERT zadr_inv_stock FROM TABLE @lt_stock
*      ACCEPTING DUPLICATE KEYS.
*
*  ENDMETHOD.
*  "-------------------------------------------------------------------------------
*  " Fill Purchase Records
*  "------------------------------------------------------------------------
*  METHOD fill_purinfos.
*    DATA lt_pinfo TYPE STANDARD TABLE OF zdr_purinfo.
*
*    CONSTANTS: lc_today    TYPE d VALUE '20250722',
*               lc_valid_to TYPE d VALUE '20260722'.
*
*    " #1 – Business laptop
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'LAPTOP001'
*                    supplier_id              = 'SUPP01'
*                    plant_id                 = 'DE01'
*                    net_price             = '720.99'
*                    currency              = 'EUR'
*                    unit_of_measure            = 'EA'
*                    price_unit            = 1
*                    minimum_order_qty         = 10
*                    delivery_time = 5
*                    valid_from            = lc_today
*                    valid_to              = lc_valid_to ) TO lt_pinfo.
*
*    " #2 – Gaming laptop
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'LAPTOP002'
*                    supplier_id              = 'SUPP01'
*                    plant_id                 = 'FR01'
*                    net_price             = '1100.99'
*                    currency              = 'EUR'
*                    unit_of_measure            = 'EA'
*                    price_unit            = 1
*                    minimum_order_qty         = 10
*                    delivery_time = 6
*                    valid_from            = lc_today
*                    valid_to              = lc_valid_to ) TO lt_pinfo.
*
*    " #3 – 24-inch monitor
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'MONITOR01'
*                    supplier_id              = 'SUPP01'
*                    plant_id                 = 'IT01'
*                    net_price             = '200.00'
*                    currency              = 'EUR'
*                    unit_of_measure           = 'EA'
*                    price_unit            = 1
*                    minimum_order_qty        = 10
*                    delivery_time = 4
*                    valid_from            = lc_today
*                    valid_to              = lc_valid_to ) TO lt_pinfo.
*
*    " #4 – Wireless mouse
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'MOUSE001'
*                    supplier_id              = 'SUPP01'
*                    plant_id                 = 'DE01'
*                    net_price             = '25.00'
*                    currency              = 'EUR'
*                    unit_of_measure            = 'EA'
*                    price_unit            = 1
*                    minimum_order_qty         = 10
*                    delivery_time = 2
*                    valid_from            = lc_today
*                    valid_to              = lc_valid_to ) TO lt_pinfo.
*
*    " #5 – Mechanical keyboard
*    APPEND VALUE #( client                = lc_client
*                    material_id              = 'KEYBD001'
*                    supplier_id              = 'SUPP01'
*                    plant_id                 = 'FR01'
*                    net_price             = '70.00'
*                    currency              = 'EUR'
*                    unit_of_measure            = 'EA'
*                    price_unit            = 1
*                    minimum_order_qty         = 10
*                    delivery_time = 3
*                    valid_from            = lc_today
*                    valid_to              = lc_valid_to ) TO lt_pinfo.
*
*    DELETE FROM zdr_purinfo.
*    INSERT zdr_purinfo FROM TABLE @lt_pinfo
*      ACCEPTING DUPLICATE KEYS.
*  ENDMETHOD.
*  "-------------------------------------------------------------------------------
*  " Bulk Upload Data
*  "------------------------------------------------------------------------
*  METHOD upload.
*
*    fill_materials(  ).
*    fill_plants(  ).
*    fill_stocks(  ).
*    fill_purinfos(  ).
*    fill_stock_status_desc(  ).
*
*  ENDMETHOD.
*
*
*  METHOD fill_stock_status_desc.
*    "-------------------------------------------------------------------------------
*    " Fill Stock Status Description
*    "------------------------------------------------------------------------
*    DATA: lt_stock_status_desc TYPE STANDARD TABLE OF zdr_stock_status.
*
*    APPEND VALUE #( stock_status_id = 1
*                    stock_status_text = 'Low' ) TO lt_stock_status_desc.
*
*    APPEND VALUE #( stock_status_id = 2
*                    stock_status_text = 'Medium' ) TO lt_stock_status_desc.
*
*    APPEND VALUE #( stock_status_id = 3
*                    stock_status_text = 'High' ) TO lt_stock_status_desc.
*
*    DELETE FROM zdr_stock_status.
*    INSERT zdr_stock_status FROM TABLE @lt_stock_status_desc
*      ACCEPTING DUPLICATE KEYS.
*
*  ENDMETHOD.
*
*
*  METHOD delete_data.
*    DELETE FROM zdr_material.
*    DELETE FROM zdr_plant.
*    DELETE FROM zadr_inv_stock.
*    DELETE FROM zdr_purinfo.
*    DELETE FROM zdr_stock_status.
*    COMMIT WORK.
*  ENDMETHOD.
*
*ENDCLASS.
