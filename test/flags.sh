#!/bin/bash
# A script to test imosh flags.

source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1

DEFINE_string 'flag' '' 'Flag name to show.'
DEFINE_bool 'show_argv' false 'Output extra argv.'
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"

if (( FLAGS_show_argv )); then
  echo "$@";
  exit
fi

if [ "${FLAGS_flag}" == '' ]; then
  LOG FATAL "flag must be specified"
fi
eval "echo -n 'FLAGS_${FLAGS_flag}='\"\${FLAGS_${FLAGS_flag}}\""
