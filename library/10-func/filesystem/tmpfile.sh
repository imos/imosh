# func::tmpfile -- Creates a temporary file.
#
# Usage:
#   // 1. Function form.
#   void func::tmpfile(string* path)
#   // 2. Command form.
#   void func::tmpfile() > path
#
# Creates a temporary file with a unique name under TMPDIR.
func::tmpfile() {
  # 1. Function form.
  if [ "$#" -eq 1 ]; then
    local __tmpfile_variable="$1"
    func::let "${__tmpfile_variable}" \
        "${TMPDIR}/tmpfile.${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}.${RANDOM}"
  # 2. Command form.
  elif [ "$#" -eq 0 ]; then
    local tmpfile=''
    # 1. Function form.
    func::tmpfile tmpfile
    func::println "${tmpfile}"
  # Argument mismatch.
  else
    LOG ERROR "The number of arguments does not match func::tmpfile: $#"
    return 1
  fi
}
