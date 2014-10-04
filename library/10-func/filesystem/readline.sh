# readline -- Gets a line.
#
# readline reads a line and regards it as a result.
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
