# atexit -- Registers a function on shutdown.
#
# atexit registers a function to be excuted on shutdown.
#
# Usage:
#     // 1. Command form.
#     void sub::atexit(string command)
sub::atexit() {
  if [ "$#" -eq 1 ]; then
    sub::println "${1}" >> "${__IMOSH_CORE_TMPDIR}/atexit.sh"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
