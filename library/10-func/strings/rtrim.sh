# func::rtrim -- Strips whitespace(s) from the end of a string.
#
# Strips whitespace (or other characters) from the end of a string.
#
# Usage:
#     // 1. Function form.
#     void func::rtrim(string* variable)
#     // 2. Command form.
#     void sub::rtrim(string value) > output
#     // 3. Stream form.
#     void stream::rtrim() < input > output
func::rtrim() {
  local __rtrim_variable="$1"

  eval "${__rtrim_variable}=\"\${${__rtrim_variable}%\"\${${__rtrim_variable}##*[![:space:]]}\"}\""
}

sub::rtrim() {
  if [ "$#" -eq 1 ]; then
    local __rtrim_value="$1"
    func::rtrim __rtrim_value
    func::println "${__rtrim_value}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}

stream::rtrim() {
  if [ "$#" -eq 0 ]; then
    :
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
