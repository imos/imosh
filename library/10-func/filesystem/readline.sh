# readline -- Gets a line.
#
# readline reads a line and sets its content to LINE and its trailing new line
# to NEWLINE.
func::readline() {
  local line=''
  NEWLINE=''
  LINE=''
  if ! func::fgets line; then
    return 1
  fi
  if [ "${line:$((${#line} - 2))}" = $'\r\n' ]; then
    NEWLINE=$'\r\n'
    LINE="${line%$'\r\n'}"
  elif [ "${line:$((${#line} - 1))}" = $'\n' ]; then
    NEWLINE=$'\n'
    LINE="${line%$'\n'}"
  else
    NEWLINE=''
    LINE="${line}"
  fi
}
