# substr -- Returns a substring.
#
# substr returns a substring of a string specfied by start and length.
#
# Usage:
#     // 1. Function form.
#     void func::substr(
#         string* output, string input, string start, string length)
#     void func::substr(
#         string* output, string input, string start)
#     // 2. Command form.
#     void sub::substr(string input, string start, string length) > output
#     void sub::substr(string input, string start) > output
func::substr() {
  if [ "$#" -eq 4 ]; then
    local __substr_size="${#2}"
    local __substr_start="${3}"
    local __substr_length="${4}"
    (( __substr_start = ( __substr_start < 0 )
                      ? __substr_size + __substr_start : __substr_start,
       __substr_start = ( __substr_start < 0 ) ? 0 : __substr_start,
       __substr_length = ( __substr_length < 0 )
                       ? __substr_size + __substr_length - __substr_start
                       : __substr_length,
       __substr_length = ( __substr_length < 0 ) ? 0 : __substr_length
    )) || true
    func::let "${1}" "${2:${__substr_start}:${__substr_length}}"
  elif [ "$#" -eq 3 ]; then
    func::substr "${1}" "${2}" "${3}" "${#2}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::substr() {
  if [ "$#" -eq 3 -o "$#" -eq 2 ]; then
    local __substr_value=''
    func::substr __substr_value "$@"
    sub::println "${__substr_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
