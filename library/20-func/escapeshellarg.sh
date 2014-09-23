# func::escapeshellarg - Escapes a variable as a shell argument.
#
# Usage:
#   void func::escapeshellarg(string* variable)
#
# Escapes variable's content.
func::escapeshellarg() {
  local __escapeshellarg_variable="$1"
  local __escapeshellarg_search="'"
  local __escapeshellarg_replace="'\\''"

  eval "${__escapeshellarg_variable}=\"'\${${__escapeshellarg_variable}//\${__escapeshellarg_search}/\${__escapeshellarg_replace}}'\""
}
