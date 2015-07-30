# md5 -- Calculates the MD5 hash of a given file.
#
# Usage:
#     // 1. Function form.
#     void func::md5_file(string* variable, string filename)
#     // 2. Command form.
#     void sub::md5_file(string filename, bool binary = false) > hash
func::md5_file() {
  if [ "$#" -eq 2 ]; then
    local __md5_file_variable="${1}"
    shift
    func::exec "${__md5_file_variable}" sub::md5_file "$@"
    func::rtrim "${__md5_file_variable}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::md5_file() {
  if [ "$#" -eq 2 ]; then
    if [ "${2}" -eq 0 ]; then
      sub::md5_file "${1}" 1 | stream::bin2hex
    else
      openssl md5 -binary "${1}"
    fi
  elif [ "$#" -eq 1 ]; then
    sub::md5_file "$@" 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
