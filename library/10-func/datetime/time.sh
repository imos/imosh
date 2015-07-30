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
    func::exec "${1}" date +'%s'
    func::rtrim "${1}"
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
