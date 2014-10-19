# array_values -- Copies elements from an array to an array.
#
# array_values copies elements in an array variable into an array variable.
#
# Usage:
#     // 1. Function form
#     void func::array_values(string[]* output, string[]* input)
func::array_values() {
  if [ "$#" -eq 2 ]; then
    if eval "[ \"\${#${2}[*]}\" -eq 0 ]"; then
      eval "${1}=()"
    else
      eval "${1}=(\"\${${2}[@]}\")"
    fi
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
