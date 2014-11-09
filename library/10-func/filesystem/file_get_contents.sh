# file_get_contents -- Reads an entire file into a string.
#
# The function form reads an entire file and sets its contents to the
# variable.  The subroutine form reads an entire file and outputs its contents
# to the standard output.  The stream form reads a file name for each line and
# outputs its contents to the standard output.
#
# Usage:
#     // 1. Function form.
#     func::file_get_contents(string* variable, string filename)
#     // 2. Subroutine form.
#     sub::file_get_contents(string filename) > output
#     // 3. Stream form.
#     stream::file_get_contents() < input > output
#
# Examples:
#     sub::print hello > "${TMPDIR}/foo"
#     func::file_get_contents variable "${TMPDIR}/foo"
#     echo "${variable}"  # => hello
#
#     sub::print hello > "${TMPDIR}/foo"
#     sub::file_get_contents "${TMPDIR}/foo"  # => hello
#
#     sub::print hello > "${TMPDIR}/foo"
#     sub::print world > "${TMPDIR}/bar"
#     { echo "${TMPDIR}/foo"; echo "${TMPDIR}/bar"; } | \
#         stream::file_get_contents  # => helloworld
func::file_get_contents() {
  if [ "$#" -eq 2 ]; then
    IFS= read -r -d '' "${1}" < "${2}" || true
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::file_get_contents() {
  if [ "$#" -eq 1 ]; then
    cat < "${1}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::file_get_contents() {
  if [ "$#" -eq 0 ]; then
    stream::array_map COMMAND cat
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
