# Usage:
#   func::bin2hex(string* destination, string data)
#   func::bin2hex() < string > string
#
# Converts binary data into hexadecimal representation.
func::bin2hex() {
  if [ "$#" -eq 0 ]; then
    od -An -tx1 | tr -d ' \n'
    return
  fi
  if [ "$#" -ne 2 ]; then
    LOG FATAL "func::bin2hex requires two arguments, but $# arguments."
    return 1
  fi
  local __bin2hex_destination="$1"
  local __bin2hex_data="$2"

  eval "${__bin2hex_destination}=\"\$(func::print \"${__bin2hex_data}\" | func::bin2hex)\""
}
