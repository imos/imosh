# Usage:
#   func::implode(string* variable, string glue, array* pieces)
#
# Join array elements with a string.
func::implode() {
  local __implode_variable="${1}"
  local __implode_glue="${2}"
  local __implode_pieces=()
  eval "local __implode_pieces=(\"\${${3}[@]}\")"

  local __implode_size="${#__implode_pieces[@]}"
  local __implode_i=0
  local __implode_result=''
  while (( __implode_i < __implode_size )); do
    if (( __implode_i != 0 )); then
      __implode_result+="${__implode_glue}"
    fi
    __implode_result+="${__implode_pieces[${__implode_i}]}"
    (( __implode_i += 1 )) || true
  done
  func::let "${__implode_variable}" "${__implode_result}"
}
