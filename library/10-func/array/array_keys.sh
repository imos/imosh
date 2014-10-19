# array_keys -- Gets an array's keys.
#
# array_keys gets an array's keys.
#
# Usage:
#     // 1. Function form
#     void func::array_keys(string[]* output, string[]* input)
func::array_keys() {
  if [ "$#" -eq 2 ]; then
    if eval "[ \"\${#${2}[*]}\" -eq 0 ]"; then
      eval "${1}=()"
    else
      eval "${1}=(\"\${!${2}[@]}\")"
    fi
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
