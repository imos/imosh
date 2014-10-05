# func::strtoupper -- Makes a string uppercase.
#
# Makes variable uppercase.
#
# Usage:
#     void func::strtoupper(string* variable)
#     void func::strtoupper() < input > output
func::strtoupper() {
  if [ "$#" -eq 0 ]; then
    tr '[a-z]' '[A-Z]'
    return
  fi
  local __strtoupper_variable="$1"
  eval "local __strtoupper_value=\"\${${__strtoupper_variable}}\""
  # This is faster than tr for short strings.
  # TODO(imos): Use ${variable^^} instead once Mac OSX supports BASH 4.
  __strtoupper_value="${__strtoupper_value//a/A}"
  __strtoupper_value="${__strtoupper_value//b/B}"
  __strtoupper_value="${__strtoupper_value//c/C}"
  __strtoupper_value="${__strtoupper_value//d/D}"
  __strtoupper_value="${__strtoupper_value//e/E}"
  __strtoupper_value="${__strtoupper_value//f/F}"
  __strtoupper_value="${__strtoupper_value//g/G}"
  __strtoupper_value="${__strtoupper_value//h/H}"
  __strtoupper_value="${__strtoupper_value//i/I}"
  __strtoupper_value="${__strtoupper_value//j/J}"
  __strtoupper_value="${__strtoupper_value//k/K}"
  __strtoupper_value="${__strtoupper_value//l/L}"
  __strtoupper_value="${__strtoupper_value//m/M}"
  __strtoupper_value="${__strtoupper_value//n/N}"
  __strtoupper_value="${__strtoupper_value//o/O}"
  __strtoupper_value="${__strtoupper_value//p/P}"
  __strtoupper_value="${__strtoupper_value//q/Q}"
  __strtoupper_value="${__strtoupper_value//r/R}"
  __strtoupper_value="${__strtoupper_value//s/S}"
  __strtoupper_value="${__strtoupper_value//t/T}"
  __strtoupper_value="${__strtoupper_value//u/U}"
  __strtoupper_value="${__strtoupper_value//v/V}"
  __strtoupper_value="${__strtoupper_value//w/W}"
  __strtoupper_value="${__strtoupper_value//x/X}"
  __strtoupper_value="${__strtoupper_value//y/Y}"
  __strtoupper_value="${__strtoupper_value//z/Z}"
  eval "${__strtoupper_variable}=\"\${__strtoupper_value}\""
}
