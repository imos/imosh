# array_values -- Copies elements from an array to an array.
#
# array_values copies elements in an array variable into an array variable.
#
# Usage:
#     // 1. Function form.
#     void func::array_values(string[]* output, string[]* input)
#     // 2. Command form.
#     void sub::array_values(string[]* input) > output
func::array_values() {
  if [ "$#" -eq 2 ]; then
    if sub::array_is_empty "${2}"; then
      eval "${1}=()"
    else
      eval "${1}=(\"\${${2}[@]}\")"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::array_values() {
  if [ "$#" -eq 1 ]; then
    local __array_values_values=()
    func::array_values __array_values_values "${1}"
    sub::implode __array_values_values
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
