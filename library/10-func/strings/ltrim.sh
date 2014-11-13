# func::ltrim -- Strips whitespace(s) from the beginning of a string.
#
# Strips whitespace (or other characters) from the beginning of a string.
#
# Usage:
#     // 1-a. Function form.
#     void func::ltrim(string* variable)
#     // 1-b. Function form.
#     void func::ltrim(string* variable, string input)
func::ltrim() {
  if [ "$#" -eq 1 ]; then
    eval "${1}=\"\${${1}#\"\${${1}%%[![:space:]]*}\"}\""
  elif [ "$#" -eq 2 ]; then
    func::let "${1}" "${2}"
    func::ltrim "${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
