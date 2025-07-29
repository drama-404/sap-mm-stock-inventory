CLASS LHC_ZRDR_INV_STOCK DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
        METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Stock
        RESULT result,

      createPurchaseRequisition FOR MODIFY
        IMPORTING keys FOR ACTION Stock~createPurchaseRequisition RESULT result.

    METHODS calculateStockStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Stock~calculateStockStatus.

    METHODS:
      validateStock FOR VALIDATE ON SAVE
        IMPORTING keys FOR Stock~validateStock.
ENDCLASS.

CLASS LHC_ZRDR_INV_STOCK IMPLEMENTATION.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Method to control who can access the BO.
  " For now,  we allow all users, we can restrict later.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  METHOD get_global_authorizations.
    DATA temp TYPE i.

    CLEAR temp.

  ENDMETHOD.

  METHOD createPurchaseRequisition.
    DATA temp TYPE i.

    LOOP AT keys INTO DATA(key).
    ENDLOOP.
  ENDMETHOD.

*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  " Method to update Reorder Point.
*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*  METHOD updateReorderPoint.
*
**    DATA: read_keys    TYPE TABLE FOR READ IMPORT zrdr_inv_stock\\Stock,
**          data_results TYPE TABLE FOR READ RESULT zrdr_inv_stock\\Stock,
**          upd_results  TYPE TABLE FOR UPDATE zrdr_inv_stock.
**
**    CLEAR read_keys.
**    read_keys = CORRESPONDING #( keys ).
**
**    READ ENTITIES OF zrdr_inv_stock IN LOCAL MODE
**      ENTITY Stock
**      ALL FIELDS WITH read_keys
**      RESULT data_results
**      FAILED failed.
**
**    LOOP AT data_results ASSIGNING FIELD-SYMBOL(<data_result>).
**
**      <data_result>-reorderpoint = keys[ %key = <data_result>-%key ]-%param-reorder_point.
**
**    ENDLOOP.
**
**    upd_results = CORRESPONDING #( data_results ).
**
**    MODIFY ENTITIES OF zrdr_inv_stock IN LOCAL MODE
**    ENTITY stock
**    UPDATE FIELDS ( reorderpoint )
**    WITH VALUE #( FOR data_result IN upd_results
**                  ( %tky   = data_result-%tky
**                    reorderpoint = data_result-reorderpoint ) )
**    REPORTED reported
**    FAILED failed.
**
**    result = VALUE #( FOR line IN data_results
**                  ( %tky-materialid   = line-materialid
**                    %tky-plantid      = line-plantid
**                    %param = CORRESPONDING #( line ) ) ).
*
*  ENDMETHOD.

  METHOD calculateStockStatus.
    DATA: lt_upd_stock TYPE TABLE FOR UPDATE zrdr_inv_stock.

    READ ENTITIES OF zrdr_inv_stock IN LOCAL MODE
    ENTITY stock
    FIELDS ( CurrentStock ReorderPoint LastGoodsIssue )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_stock).

    LOOP AT lt_stock ASSIGNING FIELD-SYMBOL(<ls_stock>).
      " 1. Calculate Stock Status (1 = OK, 2 = Warning, 3 = Critical)
      <ls_stock>-StockStatus = COND i( WHEN <ls_stock>-CurrentStock <= <ls_stock>-ReorderPoint
                                          THEN 1
                                       WHEN <ls_stock>-CurrentStock <= ( <ls_stock>-ReorderPoint * '1.2' )
                                          THEN 2
                                       ELSE 3 ).

      "2. Calculate Days of Stock
      DATA(today) = cl_abap_context_info=>get_system_date( ).
      DATA(lv_days_since_issue) = COND #( WHEN today - <ls_stock>-LastGoodsIssue = 0 THEN 30
                                           ELSE today - <ls_stock>-LastGoodsIssue ).
      <ls_stock>-DaysOfStock = COND #( WHEN lv_days_since_issue = 0 THEN 0
                                       ELSE <ls_stock>-CurrentStock / lv_days_since_issue ).

    ENDLOOP.

    lt_upd_stock = CORRESPONDING #( lt_stock ).

    MODIFY ENTITIES OF zrdr_inv_stock IN LOCAL MODE
    ENTITY Stock
    UPDATE FIELDS ( StockStatus DaysOfStock )
    WITH lt_upd_stock
    REPORTED DATA(reported_records).

    reported-Stock = CORRESPONDING #( reported_records-Stock ).
  ENDMETHOD.

  METHOD validateStock.

    "----Read fields that may contain invalid stock values
    READ ENTITIES OF zrdr_inv_stock IN LOCAL MODE
    ENTITY Stock
    FIELDS ( CurrentStock MinimumStock MaximumStock SafetyStock ReorderPoint StockValue UnitOfMeasure )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_stock).

    LOOP AT lt_stock ASSIGNING FIELD-SYMBOL(<ls_stock>).
      "1. Check for negative stock values
      IF <ls_stock>-CurrentStock  < 0 OR
           <ls_stock>-MinimumStock  < 0 OR
           <ls_stock>-MaximumStock  < 0 OR
           <ls_stock>-SafetyStock   < 0 OR
           <ls_stock>-ReorderPoint  < 0 OR
           <ls_stock>-StockValue    < 0.

        DATA(lv_v1) = COND #( WHEN <ls_stock>-CurrentStock  < 0 THEN 'Current Stock'
                              WHEN <ls_stock>-MinimumStock < 0  THEN 'Minimum Stock'
                              WHEN <ls_stock>-SafetyStock < 0   THEN 'Safety Stock'
                              WHEN <ls_stock>-ReorderPoint < 0  THEN 'Reorder Point'
                              ELSE 'Stock Value' ).
        DATA(lv_affected_field) = COND #( WHEN <ls_stock>-CurrentStock  < 0 THEN <ls_stock>-CurrentStock
                                          WHEN <ls_stock>-MinimumStock < 0  THEN <ls_stock>-MinimumStock
                                          WHEN <ls_stock>-SafetyStock < 0   THEN <ls_stock>-SafetyStock
                                          WHEN <ls_stock>-SafetyStock < 0   THEN <ls_stock>-SafetyStock
                                          ELSE <ls_stock>-StockValue ).


        "----- Report Error Message
        DATA(message) = me->new_message( id       = 'ZMC_STOCK'
                                         number   = '001'
                                         v1       = lv_v1
                                         severity = ms-error ).

        APPEND VALUE #( %tky                  = <ls_stock>-%tky
                        %msg                  = message
                        %element-CurrentStock = COND #( WHEN lv_affected_field = <ls_stock>-CurrentStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-MinimumStock = COND #( WHEN lv_affected_field = <ls_stock>-MinimumStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-MaximumStock = COND #( WHEN lv_affected_field = <ls_stock>-MaximumStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-ReorderPoint = COND #( WHEN lv_affected_field = <ls_stock>-ReorderPoint THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-SafetyStock  = COND #( WHEN lv_affected_field = <ls_stock>-SafetyStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-StockValue   = COND #( WHEN lv_affected_field = <ls_stock>-StockValue THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                         ) TO reported-stock.

        "---- Prevent Save
        APPEND VALUE #( %tky = <ls_stock>-%tky ) TO failed-stock.
      ENDIF.

      "2. Check if Minimum Stock is not > Maximum Stock
      IF <ls_stock>-MinimumStock > <ls_stock>-MaximumStock.
        "---- Report error message
        message = me->new_message( id       = 'ZMC_STOCK'
                                   number   = '002'
                                   severity = ms-error ).
        APPEND VALUE #( %tky = <ls_stock>-%tky
                        %msg = message
                        %element-MinimumStock = if_abap_behv=>mk-on
                        %element-MaximumStock = if_abap_behv=>mk-on ) TO reported-stock.
        "---- Prevent save
        APPEND VALUE #( %tky = <ls_stock>-%tky ) TO failed-stock.
      ENDIF.

      "3. Check that Safety ≤ Reorder ≤ Max
      IF <ls_stock>-SafetyStock > <ls_stock>-ReorderPoint OR
         <ls_stock>-SafetyStock > <ls_stock>-MaximumStock OR
         <ls_stock>-ReorderPoint > <ls_stock>-MaximumStock.

        message = me->new_message( id       = 'ZMC_STOCK'
                                   number   = '003'
                                   severity = ms-error ).
        APPEND VALUE #( %tky = <ls_stock>-%tky
                        %msg = message
                        %element-safetystock = COND #( WHEN <ls_stock>-SafetyStock > <ls_stock>-ReorderPoint THEN if_abap_behv=>mk-on
                                                       WHEN <ls_stock>-SafetyStock > <ls_stock>-MaximumStock THEN if_abap_behv=>mk-on
                                                       ELSE if_abap_behv=>mk-off )
                        %element-reorderpoint = COND #( WHEN <ls_stock>-SafetyStock > <ls_stock>-ReorderPoint THEN if_abap_behv=>mk-on
                                                        WHEN <ls_stock>-ReorderPoint > <ls_stock>-MaximumStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                        %element-maximumstock = COND #( WHEN <ls_stock>-SafetyStock > <ls_stock>-MaximumStock THEN if_abap_behv=>mk-on
                                                        WHEN <ls_stock>-ReorderPoint > <ls_stock>-MaximumStock THEN if_abap_behv=>mk-on
                                                        ELSE if_abap_behv=>mk-off )
                         ) TO reported-stock.
        APPEND VALUE #( %tky = <ls_stock>-%tky ) TO failed-stock.
      ENDIF.
*
*      "4. Check for Unit of Measure Consistency
      IF <ls_stock>-UnitOfMeasure IS INITIAL.
        APPEND VALUE #( %tky = <ls_stock>-%tky
                        %msg = new_message( id       = 'ZMC_STOCK'
                                            number   = '006'
                                            severity = ms-error )
                        %element-UnitOfMeasure = if_abap_behv=>mk-on ) TO reported-stock.
        APPEND VALUE #( %tky = <ls_stock>-%tky ) TO failed-stock.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
