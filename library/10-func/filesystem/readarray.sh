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
    local ifs="${IFS}"
    func::str_replace ifs '[' '\['
    func::str_replace ifs ']' '\]'
    func::greg_split LINE "[${ifs}]" "${LINE}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
