# rtrim -- Strips whitespace(s) from the end of a string.
#
# Strips whitespace (or other characters) from the end of a string.
#
# Usage:
#     // 1-a. Function form.
#     void func::rtrim(string* output, string input)
#     // 1-b. Function form.
#     void func::rtrim(string* variable)
#     // 3. Command form.
#     void sub::rtrim(string value) > output
#     // 4. Stream form.
#     void stream::rtrim() < input > output
func::rtrim() {
  if [ "$#" -eq 1 ]; then
    eval "${1}=\"\${${1}%\"\${${1}##*[![:space:]]}\"}\""
  elif [ "$#" -eq 2 ]; then
    func::let "${1}" "${2}"
    func::rtrim "${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::rtrim() {
  if [ "$#" -eq 1 ]; then
    local __rtrim_value="$1"
    func::rtrim __rtrim_value
    sub::println "${__rtrim_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::rtrim() {
  if [ "$#" -eq 0 ]; then
    local LINE='' NEWLINE=''
    while func::readline; do
      func::rtrim LINE
      sub::print "${LINE}${NEWLINE}"
    done
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
