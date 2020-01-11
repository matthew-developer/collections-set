CLASS ycl_set DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    TYPES: BEGIN OF ts_set,
             object TYPE string,
           END OF ts_set,
           tt_set TYPE STANDARD TABLE OF ts_set WITH EMPTY KEY.
    DATA: mt_set TYPE tt_set.
    METHODS:
      add_object
        IMPORTING iv_object TYPE string,
      contain_object
        IMPORTING iv_object       TYPE string
        RETURNING VALUE(rv_value) TYPE abap_bool,
      delete_object
        IMPORTING iv_object TYPE string,
      get_set
        RETURNING VALUE(rt_set) TYPE tt_set.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_index,
             object TYPE i,
           END OF ts_index,
           tt_index TYPE STANDARD TABLE OF ts_set WITH EMPTY KEY.
    DATA: mt_index TYPE tt_index.

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
          iv_index TYPE i,
      shuffle_set
        IMPORTING it_set TYPE tt_set
        RETURNING VALUE(rt_set) TYPE tt_set,
    get_object_at_index
      IMPORTING
        iv_index TYPE i
      RETURNING VALUE(rv_object) TYPE string,
     shuffle
        IMPORTING io_random_number TYPE REF TO cl_abap_random_int
        RETURNING VALUE(rt_set) TYPE tt_set.

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

  METHOD get_set.
    mt_set = shuffle_set( mt_set ).
  ENDMETHOD.

  METHOD shuffle_set.

    DATA(mo_random_number) = cl_abap_random_int=>create( min = 1 max = lines( mt_set ) ).

    WHILE lines( mt_set ) <> lines( rt_set ).
        rt_set = shuffle( mo_random_number ).
    ENDWHILE.

  ENDMETHOD.

  METHOD shuffle.
        DATA(lv_object) = get_object_at_index( io_random_number->get_next( ) ).

        DATA(ls_set_line) = VALUE #( rt_set[ object = lv_object  ] OPTIONAL ).
        IF ls_set_line IS INITIAL.
            APPEND VALUE #( object = lv_object ) TO rt_set.
        ENDIF.
  ENDMETHOD.

  METHOD get_object_at_index.
    rv_object  = mt_set[ iv_index ]-object.
  ENDMETHOD.


ENDCLASS.
