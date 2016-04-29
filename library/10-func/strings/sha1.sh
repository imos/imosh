# sha1 -- Calculates a MD5 hash.
#
# Usage:
#     // 1. Function form.
#     void func::sha1(string* variable, string data)
#     // 2. Command form.
#     void sub::sha1(string data, bool binary = false) > hash
#     // 3. Stream form.
#     void stream::sha1(bool binary = false) < input > hash
func::sha1() {
  if [ "$#" -eq 2 ]; then
    local __sha1_file=''
    func::tmpfile __sha1_file
    sub::sha1 "${2}" 0 > "${__sha1_file}"
    func::file_get_contents "${1}" "${__sha1_file}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::sha1() {
  if [ "$#" -eq 2 ]; then
    sub::print "${1}" | stream::sha1 "${2}"
  elif [ "$#" -eq 1 ]; then
    sub::sha1 "$@" 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::sha1() {
  if [ "$#" -eq 1 ]; then
    if [ "${1}" -eq 0 ]; then
      stream::sha1 1 | stream::bin2hex
    else
      openssl sha1 -binary
    fi
  elif [ "$#" -eq 0 ]; then
    stream::sha1 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
