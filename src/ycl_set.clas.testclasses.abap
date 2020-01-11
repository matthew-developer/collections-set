CLASS test DEFINITION FOR TESTING
RISK LEVEL HARMLESS
DURATION SHORT.

PRIVATE SECTION.
DATA: mo_cut TYPE REF TO ycl_set.

METHODS:
        setup,
        "It should
        add_object_initial_A_to_set     FOR TESTING,
        contain_object_A_in_set         FOR TESTING,
        delete_object_a_from_set          FOR TESTING.

ENDCLASS.

CLASS test IMPLEMENTATION.

  METHOD setup.
    mo_cut = new ycl_set( ).
  ENDMETHOD.

  METHOD add_object_initial_A_to_set.
    cl_abap_unit_assert=>assert_equals( msg = 'Should add object A'
                                        exp = abap_true
                                        act = mo_cut->add_object( 'A' )
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

ENDCLASS.
