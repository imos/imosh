# time -- Returns current Unix timestamp.
#
# time returns current Unix timestamp.
#
# Usage:
#     // 1. Function form.
#     void func::time(string* result)
#     // 2. Command form.
#     void sub::time() > output
func::time() {
  if [ "$#" -eq 1 ]; then
    sub::let "${1}" "$(date +'%s')"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::time() {
  if [ "$#" -eq 0 ]; then
    date +'%s'
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
