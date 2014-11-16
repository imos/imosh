# count -- Counts the number of elements.
#
# count counts the number of elements of an array.
#
# Usage:
#     // 1. Function form
#     void func::count(int* result, string[]* values)
#     // 2. Command form
#     void sub::count(string[]* values) > result
func::count() {
  if [ "$#" -eq 2 ]; then
    func::strcpy "${1}" "#${2}[*]"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::count() {
  if [ "$#" -eq 1 ]; then
    eval "sub::println \"\${#${1}[*]}\""
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
