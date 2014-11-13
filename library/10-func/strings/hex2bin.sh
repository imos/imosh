# func::hex2bin -- Decodes a hexadecimally encoded binary string.
#
# Decodes a hexadecimally encoded binary string.
#
# Usage:
#     // 1-a. Function form.
#     void func::hex2bin(string* output, string input)
#     // 1-b. Function form.
#     void func::hex2bin(string* variable)
#     // 2. Command form.
#     void sub::hex2bin(string input) > output
#     // 3. Stream form.
#     void stream::hex2bin() < input > output
func::hex2bin() {
  if [ "$#" -eq 2 ]; then
    local __hex2bin_result=''
    __func::hex2bin <<<"${2}"
    func::let "${1}" "${__hex2bin_result}"
  elif [ "$#" -eq 1 ]; then
    local __hex2bin_data=''
    func::strcpy __hex2bin_data "${1}"
    func::hex2bin "${1}" "${__hex2bin_data}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::hex2bin() {
  if [ "$#" -eq 1 ]; then
    stream::hex2bin <<<"${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::hex2bin() {
  if [ "$#" -eq 0 ]; then
    local __hex2bin_variable=''
    __func::hex2bin
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

__func::hex2bin() {
  local __hex2bin_char='' __hex2bin_buffer=''
  while read -n 1 __hex2bin_char; do
    case "${__hex2bin_char}" in
      [0-9a-fA-F]) __hex2bin_buffer+="${__hex2bin_char}";;
      *) continue;;
    esac
    if [ "${#__hex2bin_buffer}" -eq 2 ]; then
      if ! func::isset __hex2bin_result; then
        printf "\\x${__hex2bin_buffer}"
      else
        eval "__hex2bin_result+=\$'\\x${__hex2bin_buffer}'"
      fi
      __hex2bin_buffer=''
    fi
  done
}
