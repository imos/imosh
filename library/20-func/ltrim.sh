# Usage:
#   void func::ltrim(string* variable)
#
# Strips whitespace (or other characters) from the beginning of a string.
func::ltrim() {
  local __ltrim_variable="$1"

  eval "${__ltrim_variable}=\"\${${__ltrim_variable}#\"\${${__ltrim_variable}%%[![:space:]]*}\"}\""
}
