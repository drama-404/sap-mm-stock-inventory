CLASS zcl_upload_demo_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_upload_demo_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

      DATA(lo_upload) = NEW lcl_upload_data( ).

   out->write( |Uploading data...| ).
   lo_upload->upload( ).
   out->write( |...Done.| ).

  ENDMETHOD.
ENDCLASS.
