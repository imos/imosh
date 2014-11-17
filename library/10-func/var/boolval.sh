# boolval -- Casts a variable as a boolean value.
#
# Casts variable as a boolean value.  If it fails, returns 1.
#
# Usage:
#     bool func::boolval(string* variable)
func::boolval() {
  if [ "$#" -eq 2 ]; then
    func::let "${1}" 0
    local __boolval_value="${2}"
    func::trim __boolval_value
    if [ "${__boolval_value}" = '' ] || \
       [[ "${__boolval_value}" =~ ^F|f|[Ff]alse$ ]]; then
      return
    elif [[ "${__boolval_value}" =~ ^T|t|[Tt]rue$ ]]; then
      func::let "${1}" 1
    else
      func::intval __boolval_value || return "$?"
      if (( __boolval_value != 0 )); then
        func::let "${1}" 1
      fi
    fi
  elif [ "$#" -eq 1 ]; then
    eval "func::boolval \"\${1}\" \"\${${1}}\" || return \"\$?\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::boolval() {
  if [ "$#" -eq 1 ]; then
    local __boolval_sub_value="${1}"
    func::booval __boolval_sub_value || return "$?"
    sub::println "${__boolval_sub_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
