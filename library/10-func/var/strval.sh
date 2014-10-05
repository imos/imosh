# func::strval -- Casts a variable as a string value.
#
# Casts variable into string type.
#
# Usage:
#     void func::strval(string* variable)
func::strval() {
  local __strval_variable="$1"

  eval "${__strval_variable}=\"\${${__strval_variable}}\""
}
