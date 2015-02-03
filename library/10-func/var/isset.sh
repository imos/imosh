# isset -- Checks if a variable exists.
#
# Returns true iff variable exists.
#
# Usage:
#     // 1. Function form.
#     void func::isset(bool* result, variant* variable)
#     // 2. Command form.
#     bool func::isset(variant* variable)
#
# CAVEATS:
#   func::isset returns true for uninitialized variables in BASH 3, and returns
#   false for them in BASH 4.
func::isset() {
  if [ "$#" -eq 2 ]; then
    eval "local __isset_state=\"\${${2}+set}\""
    if [ "${__isset_state}" = 'set' ]; then
      func::let "${1}" 1
    else
      func::let "${1}" 0
    fi
  elif [ "$#" -eq 1 ]; then
    DEPRECATED
    sub::isset "$@" || return "$?"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::isset() {
  if [ "$#" -eq 1 ]; then
    local __isset_return=0
    func::isset __isset_return "${1}"
    (( __isset_return )) || return 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
