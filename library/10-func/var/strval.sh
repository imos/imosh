# strval -- Casts a variable as a string value.
#
# Casts variable into string type.
#
# Usage:
#     void func::strval(string* variable)
func::strval() {
  if [ "$#" -eq 1 ]; then
    eval "${1}=\"\${${1}}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
