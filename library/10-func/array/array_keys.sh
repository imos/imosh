# array_keys -- Gets an array's keys.
#
# array_keys gets an array's keys.
#
# Usage:
#     // 1. Function form.
#     void func::array_keys(string[]* output, string[]* input)
#     // 2. Command form.
#     void sub::array_keys(string[]* input) > output
#
# Examples:
#     array=([0]=abc [2]=def)
#     EXPECT_EQ '0,2' "$(IFS=, sub::array_keys array)"
#     func::array_keys result array
#     EXPECT_EQ '0' "${result[0]}"
#     EXPECT_EQ '2' "${result[1]}"
func::array_keys() {
  if [ "$#" -eq 2 ]; then
    if eval "[ \"\${#${2}[*]}\" -eq 0 ]"; then
      eval "${1}=()"
    else
      eval "${1}=(\"\${!${2}[@]}\")"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::array_keys() {
  if [ "$#" -eq 1 ]; then
    local __array_keys_values=()
    func::array_keys __array_keys_values "${1}"
    sub::implode __array_keys_values
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
