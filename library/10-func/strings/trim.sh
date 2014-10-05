# func::trim -- Strips whitespaces from both sides.
#
# trim strips whitespaces (or other characters) from the beginning and end of a
# string.
#
# Usage:
#     // 1. Function format.
#     void func::trim(string* output, string input)
#     // 2. Inplace format.
#     void func::trim(string* variable)
func::trim() {
  if [ "$#" -eq 1 ]; then
    local __trim_variable="$1"
    func::rtrim "${__trim_variable}"
    func::ltrim "${__trim_variable}"
  elif [ "$#" -eq 2 ]; then
    local __trim_output="$1"
    local __trim_input="$2"
    func::let "${__trim_output}" "${__trim_input}"
    func::trim "${__trim_output}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
