# explode -- Splits a string by a substring.
#
# Splits a string by string.
#
# Usage:
#     // 1. Function form.
#     void func::explode(string* variable, string delimiter, string value)
func::explode() {
  if [ "$#" -eq 3 ]; then
    local __explode_value="${3}"
    if [ "${2}" != $'\x02' ]; then
      func::str_replace __explode_value "${2}" $'\x02'
    fi
    local __explode_result=()
    local __explode_term=''
    while IFS= read -r -d $'\x02' __explode_term; do
      __explode_result+=("${__explode_term}")
    done <<<"${__explode_value}"$'\x02'
    func::array_values "${1}" __explode_result
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
