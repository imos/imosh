# let -- Assigns a value into a variable.
#
# Assigns value into *destination.
#
# Usage:
#     // 1. Function form.
#     func::let(string* destination, string value)
func::let() {
  if [ "$#" -eq 2 ]; then
    eval "${1}=\"\${2}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
