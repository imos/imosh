# Usage:
#   bool func::isset(variant* variable)
#
# Returns true iff variable exists.
#
# CAVEATS: func::isset returns true for uninitialized variables in BASH 3, and
#          returns false for them in BASH 4.
func::isset() {
  local __isset_variable="$1"

  eval "local __isset_state=\"\${${__isset_variable}+set}\""
  if [ "${__isset_state}" = 'set' ]; then
    return 0
  fi
  return 1
}
