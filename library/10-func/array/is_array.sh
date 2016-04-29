# in_array -- Finds whether a variable is an array.
#
# Finds whether the given variable is an array.
#
# Usage:
#     // 1. Command form.
#     bool sub::is_array(string[]* variable)
sub::is_array() {
  if [ "$#" -eq 1 ]; then
    if [ "${1%]}" != "${1}" ]; then
      return 1
    fi
    while :; do
      local key=0
      func::rand key 2147483647
      if sub::isset "${1}[$key]"; then
        continue
      fi
      if unset "${1}[$key]"; then
        return 0
      fi
      return 1
    done
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
