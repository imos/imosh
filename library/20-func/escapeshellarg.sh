# Usage:
#   func::escapeshellarg variable
#
# Escapes variable's content.
func::escapeshellarg() {
  local __escapeshellarg_variable="$1"
  local __escapeshellarg_search="'"
  local __escapeshellarg_replace="'\\''"

  eval "${__escapeshellarg_variable}=\"'\${${__escapeshellarg_variable}//\${__escapeshellarg_search}/\${__escapeshellarg_replace}}'\""
}
