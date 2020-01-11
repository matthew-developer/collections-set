CLASS ycl_set DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      add_object
        IMPORTING iv_object TYPE string,
      contain_object
        IMPORTING iv_object       TYPE string
        RETURNING VALUE(rv_value) TYPE abap_bool,
      delete_object
        IMPORTING iv_object TYPE string.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_set,
             object TYPE string,
           END OF ts_set.
    DATA: mt_set TYPE STANDARD TABLE OF ts_set.
    METHODS:
      add_object_to_set
        IMPORTING
          iv_object       TYPE string
        RETURNING
          VALUE(rv_value) TYPE abap_bool,
      object_not_exist_in_set
        IMPORTING iv_object       TYPE string
        RETURNING VALUE(rv_value) TYPE string,
      exists_object_in_set
        IMPORTING
          iv_object        TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      get_index_of_object_in_set
        IMPORTING
          iv_object             TYPE string
        RETURNING VALUE(rv_table_index) TYPE i,
      delete_object_at_index_in_set
        IMPORTING
          iv_index TYPE i.

ENDCLASS.

CLASS ycl_set IMPLEMENTATION.

  METHOD add_object.
    IF object_not_exist_in_set( iv_object ).
       add_object_to_set( iv_object ).
    ENDIF.
  ENDMETHOD.

  METHOD contain_object.
    rv_value = exists_object_in_set( iv_object ).
  ENDMETHOD.

  METHOD delete_object.
    IF exists_object_in_set( iv_object ).
      delete_object_at_index_in_set( get_index_of_object_in_set( iv_object ) ).
    ENDIF.
  ENDMETHOD.

  METHOD add_object_to_set.
    APPEND VALUE #( object = iv_object ) TO mt_set.
  ENDMETHOD.

  METHOD object_not_exist_in_set.
    IF contain_object( iv_object ) = abap_false.
      rv_value = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD exists_object_in_set.
    DATA(lv_object) = VALUE #( mt_set[ object = iv_object ] OPTIONAL ).
    rv_result = boolc( lv_object IS NOT INITIAL ).
  ENDMETHOD.

  METHOD get_index_of_object_in_set.
    rv_table_index  = line_index(  mt_set[ object = iv_object ] ).
  ENDMETHOD.


  METHOD delete_object_at_index_in_set.

    DELETE mt_set INDEX iv_index.

  ENDMETHOD.

ENDCLASS.
