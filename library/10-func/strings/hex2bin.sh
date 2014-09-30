# func::hex2bin -- Decodes a hexadecimally encoded binary string.
#
# Usage:
#   void func::hex2bin(string* output, string input)
#   void func::hex2bin(string* variable)
#   void func::hex2bin() < input > output
#
# Decodes a hexadecimally encoded binary string.
func::hex2bin() {
  if [ "$#" -eq 0 ]; then
    local __hex2bin_variable=''
    __func::hex2bin
  elif [ "$#" -eq 2 ]; then
    local __hex2bin_variable="$1" __hex2bin_data="$2" __hex2bin_result=''
    __func::hex2bin <<<"${__hex2bin_data}"
    func::let "${__hex2bin_variable}" "${__hex2bin_result}"
  elif [ "$#" -eq 1 ]; then
    local __hex2bin_variable="$1" __hex2bin_result=''
    eval "func::hex2bin \"\${__hex2bin_variable}\" \"\${${__hex2bin_variable}}\""
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
      if [ "${__hex2bin_variable}" = '' ]; then
        printf "\\x${__hex2bin_buffer}"
      else
        eval "__hex2bin_result+=\$'\\x${__hex2bin_buffer}'"
      fi
      __hex2bin_buffer=''
    fi
  done
}
