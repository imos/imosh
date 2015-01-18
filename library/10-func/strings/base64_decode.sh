# base64_decode -- Decodes data with MIME base64.
#
# Usage:
#     // 1. Function form.
#     void func::base64_decode(string* variable, string data)
#     // 2. Command form.
#     void sub::base64_decode(string data) > output
#     // 3. Stream form.
#     void stream::base64_decode() < input > output
func::base64_decode() {
  if [ "$#" -eq 2 ]; then
    local __base64_decode_file=''
    func::tmpfile __base64_decode_file
    sub::print "${2}" | stream::base64_decode >"${__base64_decode_file}"
    func::file_get_contents "${1}" "${__base64_decode_file}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::base64_decode() {
  if [ "$#" -eq 1 ]; then
    sub::print "${1}" | stream::base64_decode
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::base64_decode() {
  if [ "$#" -eq 0 ]; then
    local __base64_decode_file=''
    func::tmpfile __base64_decode_file
    tr -cd '[:alnum:]/+' >"${__base64_decode_file}"
    wc -c <"${__base64_decode_file}" >"${__base64_decode_file}.count"
    local __base64_decode_count=0
    func::file_get_contents \
        __base64_decode_count "${__base64_decode_file}.count"
    local __base64_decode_suffix='===='
    sub::print "${__base64_decode_suffix:0:$(( 3 - (__base64_decode_count + 3) % 4 ))}" >>"${__base64_decode_file}"
    base64 --decode -i "${__base64_decode_file}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
