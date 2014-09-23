# func::strval -- Casts a variable as a string value.
#
# Usage:
#   void func::strval(string* variable)
#
# Casts variable into string type.
func::strval() {
  local __strval_variable="$1"

  eval "${__strval_variable}=\"\${${__strval_variable}}\""
}
