# func::ltrim -- Strips whitespace(s) from the beginning of a string.
#
# Strips whitespace (or other characters) from the beginning of a string.
#
# Usage:
#     void func::ltrim(string* variable)
func::ltrim() {
  if [ "$#" -eq 1 ]; then
    local __ltrim_variable="$1"
    eval "${__ltrim_variable}=\"\${${__ltrim_variable}#\"\${${__ltrim_variable}%%[![:space:]]*}\"}\""
  elif [ "$#" -eq 2 ]; then
    local __ltrim_output="$1"
    local __ltrim_input="$2"
    func::let "${__ltrim_output}" "${__ltrim_input}"
    func::ltrim "${__ltrim_output}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
