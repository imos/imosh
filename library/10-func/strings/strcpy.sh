# strcpy -- Copies a string from a variable to another variable.
#
# Assigns the content of a variable specified as source into destination.
#
# Usage:
#     // 1. Function form.
#     void func::strcpy(string* destination, string *source)
func::strcpy() {
  if [ "$#" -eq 2 ]; then
    eval "${1}=\"\${${2}}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
