# array_is_empty -- Checks if an array is empty.
#
# array_is_empty returns true iff a given array is empty.
#
# Usage:
#     // 1. Command form.
#     bool sub::array_is_empty(string[]* variable)
#
# Example:
#     array=()
#     if sub::array_is_empty array; then
#       echo 'array is empty.'
#     fi
sub::array_is_empty() {
  if [ "$#" -eq 1 ]; then
    if eval "[ \"\${#${1}[*]}\" -eq 0 ]"; then return 0; fi
    return 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
