# trim -- Strips whitespaces from both sides.
#
# trim strips whitespaces (or other characters) from the beginning and end of a
# string.
#
# Usage:
#     // 1-a. Function format.
#     void func::trim(string* output, string input)
#     // 1-b. Function format.
#     void func::trim(string* variable)
func::trim() {
  if [ "$#" -eq 1 ]; then
    func::rtrim "${1}"
    func::ltrim "${1}"
  elif [ "$#" -eq 2 ]; then
    func::let "${1}" "${2}"
    func::trim "${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
