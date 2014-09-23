# func::strtolower -- Makes a string lowercase.
#
# Usage:
#   void func::strtolower(string* variable)
#   void func::strtolower() < input > output
#
# Makes variable lowercase.
func::strtolower() {
  if [ "$#" -eq 0 ]; then
    tr '[A-Z]' '[a-z]'
    return
  fi
  local __strtolower_variable="$1"
  eval "local __strtolower_value=\"\${${__strtolower_variable}}\""
  # This is faster than tr for short strings.
  # TODO(imos): Use ${variable,,} instead once Mac OSX supports BASH 4.
  __strtolower_value="${__strtolower_value//A/a}"
  __strtolower_value="${__strtolower_value//B/b}"
  __strtolower_value="${__strtolower_value//C/c}"
  __strtolower_value="${__strtolower_value//D/d}"
  __strtolower_value="${__strtolower_value//E/e}"
  __strtolower_value="${__strtolower_value//F/f}"
  __strtolower_value="${__strtolower_value//G/g}"
  __strtolower_value="${__strtolower_value//H/h}"
  __strtolower_value="${__strtolower_value//I/i}"
  __strtolower_value="${__strtolower_value//J/j}"
  __strtolower_value="${__strtolower_value//K/k}"
  __strtolower_value="${__strtolower_value//L/l}"
  __strtolower_value="${__strtolower_value//M/m}"
  __strtolower_value="${__strtolower_value//N/n}"
  __strtolower_value="${__strtolower_value//O/o}"
  __strtolower_value="${__strtolower_value//P/p}"
  __strtolower_value="${__strtolower_value//Q/q}"
  __strtolower_value="${__strtolower_value//R/r}"
  __strtolower_value="${__strtolower_value//S/s}"
  __strtolower_value="${__strtolower_value//T/t}"
  __strtolower_value="${__strtolower_value//U/u}"
  __strtolower_value="${__strtolower_value//V/v}"
  __strtolower_value="${__strtolower_value//W/w}"
  __strtolower_value="${__strtolower_value//X/x}"
  __strtolower_value="${__strtolower_value//Y/y}"
  __strtolower_value="${__strtolower_value//Z/z}"
  eval "${__strtolower_variable}=\"\${__strtolower_value}\""
}
