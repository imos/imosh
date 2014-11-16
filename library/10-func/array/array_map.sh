# array_map -- Applies a callback to elements.
#
# array_map applies a callback to every element.  stream::array_map applies a
# callback to every line's elements.
# stream::array_map supports the following functions: array, function, inplace
# and command.
#
# Usage:
#     // 1. Function form.
#     void func::array_map(string[]* variable, string type,
#                          string callback [, string arguments...])
#     // 2. Stream form.
#     void stream::array_map(
#         string type, string callback [, string arguments...])
#         < input > output
#
# Type:
# - ARRAY
#     Reads every line as an array, and applies a callback to every line.
# - FUNCTION
#     Reads every line as a string and applies a callback.  A callback should be
#     a function format like: function(string* output, input).
# - INPLACE
#     Reads every line as a string and applies a callback.  A callback should be
#     an inplace format like: function(string* input_and_output).
# - COMMAND
#     Reads every line as a string and applies a callback.  A callback should be
#     a command format like: function(string input) > output.
#
# Examples:
#     input=('abc' 'DeF' '012')
#     func::array_map input INPLACE func::strtoupper
#     echo "${input[@]}" # => ABC DEF 012
#
#     sub::print $'def,abc,ghi\n1,3,2,5,4' | \
#         IFS=',' stream::array_map ARRAY func::sort
#         # => abc,def,ghi\n1,2,3,4,5
#
#     sub::print $'abcbd\nbcdbcb' | \
#         stream::array_map INPLACE func::str_replace 'bc' 'BC'
#         # => aBCbd\nBCdBCb
func::array_map() {
  if [ "$#" -ge 3 ]; then
    if sub::array_is_empty "${1}"; then return; fi
    local __array_map_variable="${1}"; shift
    local __array_map_type="${1}"; shift
    local __array_map_callback="${1}"; shift

    local __array_map_keys=()
    local __array_map_key=''
    func::array_keys __array_map_keys "${__array_map_variable}"
    case "${__array_map_type}" in
      'ARRAY')
        local __array_map_value=''
        local __array_map_array_value=()
        for __array_map_key in "${__array_map_keys[@]}"; do
          func::strcpy __array_map_value \
                       "${__array_map_variable}[${__array_map_key}]"
          func::array __array_map_array_value "${__array_map_value}"
          "${__array_map_callback}" __array_map_array_value "$@"
          func::let "${__array_map_variable}[${__array_map_key}]" \
                    "${__array_map_array_value[*]}"
        done
        ;;
      'FUNCTION')
        local __array_map_value=''
        for __array_map_key in "${__array_map_keys[@]}"; do
          func::strcpy __array_map_value \
                       "${__array_map_variable}[${__array_map_key}]"
          "${__array_map_callback}" \
              "${__array_map_variable}[${__array_map_key}]" \
              "${__array_map_value}" "$@"
        done
        ;;
      'INPLACE')
        local __array_map_value=''
        for __array_map_key in "${__array_map_keys[@]}"; do
          "${__array_map_callback}" \
              "${__array_map_variable}[${__array_map_key}]" "$@"
        done
        ;;
      'COMMAND')
        local __array_map_value=''
        local __array_map_tmpfile=''
        func::tmpfile __array_map_tmpfile
        for __array_map_key in "${__array_map_keys[@]}"; do
          func::strcpy __array_map_value \
                       "${__array_map_variable}[${__array_map_key}]"
          "${__array_map_callback}" \
              "${__array_map_value}" "$@" > "${__array_map_tmpfile}"
          func::file_get_contents \
              "${__array_map_variable}[${__array_map_key}]" \
              "${__array_map_tmpfile}"
        done
        ;;
      *)
        LOG ERROR "Unknown array_map type: ${__array_map_type}"
        return 2
        ;;
    esac
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::array_map() {
  if [ "$#" -ge 2 ]; then
    local __array_map_type="${1}"
    local LINE='' NEWLINE=''
    while func::readline; do
      local __array_map_line=("${LINE}")
      func::array_map __array_map_line "$@"
      if [ "${__array_map_type}" = 'COMMAND' ]; then
        sub::print "${__array_map_line[0]}"
      else
        sub::print "${__array_map_line[0]}${NEWLINE}"
      fi
    done
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
