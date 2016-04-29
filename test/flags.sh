#!/bin/bash
# A script to test imosh flags.

source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1

DEFINE_string 'flag' '' 'Flag name to show.'
DEFINE_bool 'show_argv' false 'Output extra argv.'
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int --alias=i 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'
DEFINE_multiint 'multiint' --alias=m 1,10,100 'Multiple integers flag.'
DEFINE_list 'list' 'a,b,c' 'Multiple strings flag.'
DEFINE_enum 'enum' 'bar' --values='foo,bar' 'Enum flag.'

IMOSH_PREDICATE="${IMOSH_TEST_PREDICATE:--1}" eval "${IMOSH_INIT}"

if (( FLAGS_show_argv )); then
  echo "$@"
  exit
fi

if [ "${FLAGS_flag}" == '' ]; then
  LOG FATAL '--flag must be specified.'
fi
if [ "${FLAGS_flag}" = 'list' -o "${FLAGS_flag:0:5}" = 'multi' ]; then
  func::array_values values "FLAGS_${FLAGS_flag}"
  if [ "${#values[*]}" -ne 0 ]; then
    for value in "${values[@]}"; do
      sub::println "${value}"
    done
  else
    sub::println 'EMPTY'
  fi
else
  eval "sub::println 'FLAGS_${FLAGS_flag}='\"\${FLAGS_${FLAGS_flag}}\""
fi
