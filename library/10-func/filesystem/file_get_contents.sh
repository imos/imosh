# func::file_get_contents, stream::file_get_contents -- Reads an entire file
# into a string.
#
# The function form reads an entire file and sets its contents to the
# variable.  The stream output form reads an entire file and outputs its
# contents to the standard output.  The stream form reads a file name for
# each line and outputs its contents to the standard output.
#
# Usage:
#     // 1. Function form.
#     func::file_get_contents(string* variable, string filename)
#     // 2. Stream output form.
#     stream::file_get_contents(string filename) > output
#     // 3. Stream form.
#     stream::file_get_contents() < input > output
#
# Examples:
#     func::print hello > "${TMPDIR}/foo"
#     func::file_get_contents variable "${TMPDIR}/foo"
#     echo "${variable}"  # => hello
#
#     func::print hello > "${TMPDIR}/foo"
#     stream::file_get_contents "${TMPDIR}/foo"  # => hello
#
#     func::print hello > "${TMPDIR}/foo"
#     func::print world > "${TMPDIR}/bar"
#     { echo "${TMPDIR}/foo"; echo "${TMPDIR}/bar"; } | \
#         stream::file_get_contents  # => helloworld
func::file_get_contents() {
  if [ "$#" -eq 2 ]; then
    local __file_get_contents_variable="$1"
    local __file_get_contents_filename="$2"

    IFS= read -r -d '' "${__file_get_contents_variable}" \
        < "${__file_get_contents_filename}" || true
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}

stream::file_get_contents() {
  if [ "$#" -eq 1 ]; then
    local __file_get_contents_filename="$1"
    cat < "${__file_get_contents_filename}"
  elif [ "$#" -eq 0 ]; then
    local __file_get_contents_filename=''
    while IFS= read -r __file_get_contents_filename; do
      cat < "${__file_get_contents_filename}"
    done
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
