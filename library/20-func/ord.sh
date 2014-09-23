# Usage:
#   func::ord(string* variable, string character)
#
# Sets ASCII value of character to variable.
func::ord() {
  local __ord_variable="$1"
  local __ord_character="$2"
  local __ord_result="$(printf '%d' \'"${__ord_character}")"
  eval "${__ord_variable}=\"\${__ord_result}\""
}
