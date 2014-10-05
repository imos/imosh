# array_map -- Applies a callback to elements.
#
# array_map applies a callback to every element.  stream::array_map applies a
# callback to every line's elements.
# stream::array_map supports the following functions: array, function, inplace
# and command.
#
# Usage:
#     void stream::array_map(
#         string type, string callback [, string arguments...])
#         < input > output
#
# Type:
# - --array
#     Reads every line as an array, and applies a callback to every line.
# - --function
#     Reads every line as a string and applies a callback.  A callback should be
#     a function format like: function(string* output, input).
# - --inplace
#     Reads every line as a string and applies a callback.  A callback should be
#     an inplace format like: function(string* input_and_output).
# - --command
#     Reads every line as a string and applies a callback.  A callback should be
#     a command format like: function(string input) > output.
stream::array_map() {
  if [ "$#" -ge 2 ]; then
    local __array_map_type="$1"; shift
    local __array_map_callback="$1"; shift

    case "${__array_map_type}" in
      '--array')
        local LINE=() NEWLINE=''
        while func::readarray; do
          "${__array_map_callback}" LINE "$@"
          if [ "${#LINE[*]}" -ne 0 ]; then
            func::print "${LINE[*]}"
          fi
          func::print "${NEWLINE}"
        done
        ;;
      '--function')
        local LINE='' NEWLINE=''
        while func::readline; do
          "${__array_map_callback}" LINE "${LINE}" "$@"
          func::print "${LINE}${NEWLINE}"
        done
        ;;
      '--inplace')
        local LINE='' NEWLINE=''
        while func::readline; do
          "${__array_map_callback}" LINE "$@"
          func::print "${LINE}${NEWLINE}"
        done
        ;;
      '--command')
        local LINE='' NEWLINE=''
        while func::readline; do
          "${__array_map_callback}" "${LINE}" "$@"
        done
        ;;
      *)
        LOG ERROR "Unknown array_map type: ${__array_map_type}"
        ;;
    esac
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
