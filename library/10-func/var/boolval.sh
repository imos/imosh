# func::boolval -- Casts a variable as a boolean value.
#
# Casts variable as a boolean value.  If it fails, returns 1.
#
# Usage:
#     bool func::boolval(string* variable)
func::boolval() {
  local __boolval_variable="$1"
  eval "local __boolval_value=\"\${${__boolval_variable}}\""

  func::trim __boolval_value
  if [ "${__boolval_value}" = '' ]; then
    __boolval_value=0
  elif [[ "${__boolval_value}" =~ ^T|t|[Tt]rue$ ]]; then
    __boolval_value=1
  elif [[ "${__boolval_value}" =~ ^F|f|[Ff]alse$ ]]; then
    __boolval_value=0
  elif func::intval __boolval_value; then
    if (( __boolval_value )); then
      __boolval_value=1
    fi
  else
    func::let "${__boolval_variable}" 0
    return 1
  fi
  func::let "${__boolval_variable}" "${__boolval_value}"
}
