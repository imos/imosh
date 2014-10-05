# func::explode -- Splits a string by a substring.
#
# Usage:
#   void func::explode(string* variable, string delimiter, string value)
#
# Splits a string by string.
func::explode() {
  local __explode_variable="${1}"
  local __explode_delimiter="${2}"
  local __explode_value="${3}"
  local __explode_result=()

  if [ "${__explode_delimiter}" != $'\x02' ]; then
    func::str_replace __explode_value "${__explode_delimiter}" $'\x02'
  fi
  while IFS='' read -r -d $'\x02' __explode_term; do
    __explode_result+=("${__explode_term}")
  done <<<"${__explode_value}"$'\x02'
  eval "${__explode_variable}=(\"\${__explode_result[@]}\")"
}
