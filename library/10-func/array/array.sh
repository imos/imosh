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
    __array_ifs="${__array_ifs//'['/\[}"
    __array_ifs="${__array_ifs//']'/\]}"
    func::greg_split "${1}" "[${__array_ifs}]" "${2}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
