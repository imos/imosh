# func::implode -- Joins array elements with a string.
#
# func::implode joins `pieces` with `glue`.
# *Stream form* uses the IFS environment variable as an input separator and
# processes line by line.
#
# Usage:
#     // 1. Function form.
#     void func::implode(string* variable, string glue, string[]* pieces)
#     // 2. Command form.
#     void sub::implode(string glue, string[]* pieces) > result
#     // 3. Stream form.
#     void stream::implode(string glue) < input > output
#
# Aliases:
#   func::join, sub::join and stream::join are aliases of func::implode,
#   sub::implode and stream::implode respectively.
func::implode() {
  # 1. Function form.
  if [ "$#" -eq 3 ]; then
    local __implode_variable="${1}"
    local __implode_glue="${2}"
    local __implode_pieces=()
    eval "local __implode_pieces=(\"\${${3}[@]}\")"

    local __implode_size="${#__implode_pieces[@]}"
    local __implode_i=0
    local __implode_result=''
    while (( __implode_i < __implode_size )); do
      if (( __implode_i != 0 )); then
        __implode_result+="${__implode_glue}"
      fi
      __implode_result+="${__implode_pieces[${__implode_i}]}"
      (( __implode_i += 1 )) || true
    done
    func::let "${__implode_variable}" "${__implode_result}"
  elif [ "$#" -eq 2 ]; then
    LOG ERROR 'This form is deprecated.'
    sub::implode "$@"
  elif [ "$#" -eq 1 ]; then
    LOG ERROR 'This form is deprecated.'
    stream::implode "$@"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::implode() {
  if [ "$#" -eq 2 ]; then
    local __implode_output=''
    func::implode __implode_output "${1}" "${2}"
    sub::println "${__implode_output}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::implode() {
  if [ "$#" -eq 1 ]; then
    local LINE=()
    while func::readarray; do
      sub::implode "${1}" LINE
    done
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

func::join() { func::implode "$@"; }
sub::join() { sub::implode "$@"; }
stream::join() { stream::implode "$@"; }
