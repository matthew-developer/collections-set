CLASS test DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

PRIVATE SECTION.
TYPES: BEGIN OF ts_set,
            object TYPE string,
       END OF ts_set,
       tt_set TYPE STANDARD TABLE OF ts_set WITH EMPTY KEY.

DATA: mo_cut TYPE REF TO ycl_set.

METHODS:
        setup,
        "It should
        add_object_initial_A_to_set     FOR TESTING,
        contain_object_A_in_set         FOR TESTING,
        delete_object_a_from_set        FOR TESTING,
        shuffle_objects_in_set          FOR TESTING.

ENDCLASS.

CLASS test IMPLEMENTATION.

  METHOD setup.
    mo_cut = new ycl_set( ).
  ENDMETHOD.

  METHOD add_object_initial_A_to_set.
    mo_cut->add_object( 'A' ).
    cl_abap_unit_assert=>assert_equals( msg = 'Should add object A'
                                        exp = abap_true
                                        act = mo_cut->contain_object( 'A' )
                                      ).

  ENDMETHOD.

  METHOD contain_object_A_in_set.
    mo_cut->add_object( 'A' ).
    cl_abap_unit_assert=>assert_equals(  msg =  'Should contain object A'
                                         exp =   abap_true
                                         act =   mo_cut->contain_object( 'A' )
                                      ).
  ENDMETHOD.

  METHOD delete_object_a_from_set.
    mo_cut->add_object( 'A'  ).
    mo_cut->delete_object( 'A' ).
    cl_abap_unit_assert=>assert_equals( msg = 'Should delete object A'
                                         exp = abap_false
                                         act = mo_cut->contain_object( 'A' )
                                       ).
  ENDMETHOD.

  METHOD shuffle_objects_in_set.
    mo_cut->add_object( 'A'  ).
    mo_cut->add_object( 'B'  ).
    mo_cut->add_object( 'C'  ).
    mo_cut->add_object( 'D'  ).

    cl_abap_unit_assert=>assert_equals( msg = 'Set should be shuffled'
                                        exp = VALUE tt_set( ( object = 'D' ) ( object = 'A' ) ( object = 'C' ) ( object = 'B' ) )
                                        act = mo_cut->get_set(  )
                                       ).
  ENDMETHOD.

ENDCLASS.
