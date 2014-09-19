# Usage:
#   func::strval variable
#
# Casts variable into string type.  If it fails, returns 1.
func::strval() {
  local __strval_variable="$1"

  eval "${__strval_variable}=\"\${${__strval_variable}}\""
}
