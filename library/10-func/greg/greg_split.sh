# func::greg_split -- Splits a string with a GREG pattern.
#
# greg_split splits a string with a GREG pattern.
#
# Usage:
#     // 1. Function form.
#     void func::greg_split(string[]* variable, string pattern, string value)
#     // 2. Command form.
#     void sub::greg_split(string pattern, string value)
#
# Caveat:
#   greg_split does not support \x02 for value.
func::greg_split() {
  if [ "$#" -eq 3 ]; then
    local __greg_split_value="${3}"
    func::greg_replace __greg_split_value "${2}" $'\x02'
    func::explode "${1}" $'\x02' "${__greg_split_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::greg_split() {
  if [ "$#" -eq 2 ]; then
    local __greg_split_variable=()
    func::greg_split __greg_split_variable "${1}" "${2}"
    sub::implode __greg_split_variable
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
