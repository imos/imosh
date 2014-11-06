# tmpfile -- Creates a temporary file.
#
# tmpfile creates a temporary file with a unique name under ${TMPDIR}.
#
# Usage:
#     // 1. Function form.
#     void func::tmpfile(string* path)
#     // 2. Command form.
#     void sub::tmpfile() > path
func::tmpfile() {
  if [ "${#}" -eq 1 ]; then
    local __tmpfile_variable="${1}"
    func::let "${__tmpfile_variable}" \
        "${TMPDIR}/tmpfile.${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::tmpfile() {
  if [ "${#}" -eq 0 ]; then
    local tmpfile=''
    func::tmpfile tmpfile
    sub::println "${tmpfile}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
