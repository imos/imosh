# Usage:
#   bool func::floatval(string* variable)
#
# Casts variable into float type.  If it fails, returns 1.
func::floatval() {
  local __floatval_variable="$1"

  local __floatval_value
  eval "__floatval_value=\"\${${__floatval_variable}}\""
  if [[ "${__floatval_value}" =~ ^[[:space:]]*(-?[0-9]+(\.[0-9]+)?) ]]; then
    func::let "${__floatval_variable}" "${BASH_REMATCH[1]}"
  else
    return 1
  fi
}
