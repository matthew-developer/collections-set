*&---------------------------------------------------------------------*
*& Report ycl_program_set
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_program_set.

data: limit type i.
data: min type i value 1,
      max type i value 3.

data:
o_rand type ref to cl_abap_random_int,
n type i.

cl_abap_random_int=>create(
exporting
min = min
max = max
receiving
prng = o_rand
).

WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
WRITE: o_rand->get_next( ).
