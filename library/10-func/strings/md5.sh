# md5 -- Calculates a MD5 hash.
#
# Usage:
#     // 1. Function form.
#     void func::md5(string* variable, string data)
#     // 2. Command form.
#     void sub::md5(string data, bool binary = false) > hash
#     // 3. Stream form.
#     void stream::md5(bool binary = false) < input > hash
func::md5() {
  if [ "$#" -eq 2 ]; then
    local __md5_file=''
    func::tmpfile __md5_file
    sub::md5 "${2}" 0 > "${__md5_file}"
    func::file_get_contents "${1}" "${__md5_file}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::md5() {
  if [ "$#" -eq 2 ]; then
    sub::print "${1}" | stream::md5 "${2}"
  elif [ "$#" -eq 1 ]; then
    sub::md5 "$@" 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::md5() {
  if [ "$#" -eq 1 ]; then
    if [ "${1}" -eq 0 ]; then
      stream::md5 1 | stream::bin2hex
    else
      openssl md5 -binary
    fi
  elif [ "$#" -eq 0 ]; then
    stream::md5 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
