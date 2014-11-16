# bin2hex -- Converts a binary string into hexadecimal representation.
#
# Converts binary data into hexadecimal representation.
#
# Usage:
#     // 1. Function form.
#     void func::bin2hex(string* hexadecimal_output, string binary_input)
#     // 2. Command form.
#     void sub::bin2hex(string binary_input) > hexadecimal_output
#     // 3. Stream form.
#     void stream::bin2hex() < binary_input > hexadecimal_output
func::bin2hex() {
  if [ "$#" -eq 2 ]; then
    func::let "${1}" "$(sub::print "${2}" | stream::bin2hex)"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::bin2hex() {
  if [ "$#" -eq 1 ]; then
    stream::bin2hex <<<"${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::bin2hex() {
  if [ "$#" -eq 0 ]; then
    od -An -tx1 | tr -d ' \n'
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
