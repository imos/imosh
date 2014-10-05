# func::bin2hex -- Converts a binary string into hexadecimal representation.
#
# Converts binary data into hexadecimal representation.
#
# Usage:
#     void func::bin2hex(string* hexadecimal_output, string binary_input)
#     void func::bin2hex(string binary_input) > hexadecimal_output
#     void func::bin2hex() < binary_input > hexadecimal_output
func::bin2hex() {
  if [ "$#" -eq 0 ]; then
    od -An -tx1 | tr -d ' \n'
    return
  elif [ "$#" -eq 1 ]; then
    func::bin2hex <<<"$1"
    return
  elif [ "$#" -ne 2 ]; then
    LOG FATAL "func::bin2hex requires two arguments, but $# arguments."
    return 1
  fi
  local __bin2hex_destination="$1"
  local __bin2hex_data="$2"

  eval "${__bin2hex_destination}=\"\$(func::print \"${__bin2hex_data}\" | func::bin2hex)\""
}
