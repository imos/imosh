# func::escapeshellarg - Escapes a variable as a shell argument.
#
# Escapes variable's content.
#
# Usage:
#   void func::escapeshellarg(string* variable)
func::escapeshellarg() {
  local __escapeshellarg_variable="$1"
  local __escapeshellarg_search="'"
  local __escapeshellarg_replace="'\\''"

  eval "${__escapeshellarg_variable}=\"'\${${__escapeshellarg_variable}//\${__escapeshellarg_search}/\${__escapeshellarg_replace}}'\""
}
