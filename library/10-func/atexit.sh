# func::atexit -- Registers a function on shutdown.
#
# Usage:
#   void func::atexit(string command)
func::atexit() {
  if [ "$#" -eq 1 ]; then
    echo "$1" >>"${__IMOSH_CORE_TMPDIR}/atexit.sh"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
