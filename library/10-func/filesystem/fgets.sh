# func::fgets -- Gets a line from STDIN.
#
# fgets reads a line and regards it as a result.  fgets does not strip a
# trailing new line.  Function form sets the result to the variable.  Subroutine
# form outputs the result to STDOUT.
#
# Usage:
#     // 1. Function form.
#     bool func::fgets(string* variable)
#     // 2. Subroutine form.
#     bool sub::fgets() > line
func::fgets() {
  local __fgets_variable="$1"
  local __fgets_buffer=''
  local __fgets_line=''

  func::let "${__fgets_variable}" ''
  if ! IFS= read -r -n 1 -d '' __fgets_buffer; then
    return 1
  fi
  __fgets_line+="${__fgets_buffer}"
  if IFS= read -r -d $'\n' __fgets_buffer; then
    __fgets_buffer+=$'\n'
  fi
  __fgets_line+="${__fgets_buffer}"
  func::strcpy "${__fgets_variable}" __fgets_line
}

sub::fgets() {
  local variable=''
  if ! func::fgets variable; then
    return 1
  fi
  func::print "${variable}"
}
