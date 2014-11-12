# func::md5 -- Calculates a MD5 hash.
#
# Usage:
#     void func::md5() < input > hash
#     void func::md5(string data) > hash
#     void func::md5(string* variable, string data)
func::md5() {
  if [ "$#" -eq 0 ]; then
    openssl md5 -binary | stream::bin2hex
  elif [ "$#" -eq 1 ]; then
    sub::print "${1}" | func::md5
  elif [ "$#" -eq 2 ]; then
    local __md5_variable="$1"
    local __md5_data="$2"
    eval "${__md5_variable}=\"\$(func::md5 \"\${__md5_data}\")\""
  fi
}
