source imosh || exit 1

DEFINE_string 'string' 'default' 'Description.'
DEFINE_int 'int' 100 'Description.'
DEFINE_bool 'bool' false 'Description.'

eval "${IMOSH_INIT}"

set | grep ^FLAGS
