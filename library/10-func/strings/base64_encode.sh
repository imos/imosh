# base64_encode -- Encodes data with MIME base64.
#
# Usage:
#     // 1. Function form.
#     void func::base64_encode(string* variable, string data)
#     // 2. Command form.
#     void sub::base64_encode(string data) > output
#     // 3. Stream form.
#     void stream::base64_encode() < input > output
func::base64_encode() {
  if [ "$#" -eq 2 ]; then
    local __base64_encode_file=''
    func::tmpfile __base64_encode_file
    sub::print "${2}" | stream::base64_encode > "${__base64_encode_file}"
    func::file_get_contents "${1}" "${__base64_encode_file}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::base64_encode() {
  if [ "$#" -eq 1 ]; then
    sub::print "${1}" | stream::base64_encode
    sub::println
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::base64_encode() {
  if [ "$#" -eq 0 ]; then
    # Remove newlines for compatibility.
    openssl enc -e -base64 | tr -cd '[:print:]'
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
