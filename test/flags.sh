source imosh || exit 1

DEFINE_string 'flag' '' 'Flag name to show.'
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"

if [ "${FLAGS_flag}" == '' ]; then
  LOG FATAL "flag must be specified"
fi
eval "echo -n 'FLAGS_${FLAGS_flag}='\"\${FLAGS_${FLAGS_flag}}\""
