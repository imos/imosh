# array -- Creates an array.
#
# array creates an array from a string with IFS separators.
#
# Usage:
#     // 1. Function form
#     void func::array(string[]* result, string input)
func::array() {
  if [ "$#" -eq 2 ]; then
    local __array_ifs="${IFS}"
    func::str_replace __array_ifs '[' '\['
    func::str_replace __array_ifs ']' '\]'
    func::greg_split "${1}" "[${__array_ifs}]" "${2}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
