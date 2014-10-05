# func::rtrim -- Strips whitespace(s) from the end of a string.
#
# Strips whitespace (or other characters) from the end of a string.
#
# Usage:
#     // 1. Function form.
#     void func::rtrim(string* output, string input)
#     // 2. Inplace form.
#     void func::rtrim(string* variable)
#     // 3. Command form.
#     void sub::rtrim(string value) > output
#     // 4. Stream form.
#     void stream::rtrim() < input > output
func::rtrim() {
  if [ "$#" -eq 1 ]; then
    local __rtrim_variable="$1"
    eval "${__rtrim_variable}=\"\${${__rtrim_variable}%\"\${${__rtrim_variable}##*[![:space:]]}\"}\""
  elif [ "$#" -eq 2 ]; then
    local __rtrim_output="$1"
    local __rtrim_input="$2"
    func::let "${__rtrim_output}" "${__rtrim_input}"
    func::rtrim "${__rtrim_output}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
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
    local LINE='' NEWLINE=''
    while func::readline; do
      func::rtrim LINE
      func::print "${LINE}${NEWLINE}"
    done
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
