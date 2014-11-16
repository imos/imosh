# readarray -- Reads a line as an array.
#
# readarray reads a line and sets its content to LINE and its trailing new line
# to NEWLINE.
#
# Usage:
#     void func::readarray() < input
func::readarray() {
  if [ "$#" -eq 0 ]; then
    NEWLINE=''
    LINE=''
    if ! func::readline; then
      LINE=()
      return 1
    fi
    func::array LINE "${LINE}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
