# readarray -- Reads a line as an array.
#
# readline reads a line and sets its content to LINE and its trailing new line
# to NEWLINE.
#
# Usage:
#     void func::readarray() < input
func::readarray() {
  local line=''
  NEWLINE=''
  LINE=''
  if ! func::readline; then
    LINE=()
    return 1
  fi
  local ifs="${IFS}"
  ifs="${ifs//'['/\[}"
  ifs="${ifs//']'/\]}"
  func::greg_split LINE "[${ifs}]" "${LINE}"
}
