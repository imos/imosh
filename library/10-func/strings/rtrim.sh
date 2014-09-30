# func::rtrim -- Strips whitespace(s) from the end of a string.
#
# Usage:
#   void func::rtrim(string* variable)
#
# Strips whitespace (or other characters) from the end of a string.
func::rtrim() {
  local __rtrim_variable="$1"

  eval "${__rtrim_variable}=\"\${${__rtrim_variable}%\"\${${__rtrim_variable}##*[![:space:]]}\"}\""
}
