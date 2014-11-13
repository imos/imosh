# str_replace -- Replaces a substring with another substring.
#
# Replace search with replace in *subject.
#
# Usage:
#     // 1. Function form.
#     void func::str_replace(string* subject, string search, string replace)
#     // 2. Command form.
#     void sub::str_replace(
#         string input, string search, string replace) > output
#     // 3. Stream form.
#     void stream::str_replace(string search, string replace) < input > output
func::str_replace() {
  if [ "$#" -eq 3 ]; then
    eval "${1}=\"\${${1}//\"\${2}\"/\${3}}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::str_replace() {
  if [ "$#" -eq 3 ]; then
    local __str_replace_value="${1}"
    func::str_replace __str_replace_value "${2}" "${3}"
    sub::println "${__str_replace_value}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::str_replace() {
  if [ "$#" -eq 2 ]; then
    local __str_replace_search="${1}"
    local __str_replace_replace="${2}"
    func::str_replace __str_replace_search '\' '\\'
    func::str_replace __str_replace_search '/' '\/'
    func::str_replace __str_replace_search '.' '\.'
    func::str_replace __str_replace_search '*' '\*'
    func::str_replace __str_replace_search '^' '\^'
    func::str_replace __str_replace_search '$' '\$'
    func::str_replace __str_replace_search '[' '\['
    func::str_replace __str_replace_search ']' '\]'
    func::str_replace __str_replace_replace '\' '\\'
    func::str_replace __str_replace_replace '/' '\/'
    func::str_replace __str_replace_replace '&' '\&'
    sed -e "s/${__str_replace_search}/${__str_replace_replace}/g"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
