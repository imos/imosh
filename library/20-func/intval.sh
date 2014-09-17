# Usage:
#   func::intval variable
#
# Casts variable into integer type.  If it fails, returns 1.
func::intval() {
  local __intval_variable="$1"

  local __intval_value
  eval "__intval_value=\"\${${__intval_variable}}\""
  if [[ "${__intval_value}" =~ ^[[:space:]]*(-?[0-9]+) ]]; then
    func::let "${__intval_variable}" "${BASH_REMATCH[1]}"
  else
    return 1
  fi
}
