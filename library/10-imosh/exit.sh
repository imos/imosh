# imosh::exit
#
# Usage:
#   void imosh::exit(int status = 0)
#
# imosh::exit kills all the subprocesses of the root process with the status.
imosh::exit() {
  if [ "$#" -eq 0 ]; then
    set -- 0
  fi
  if [ "$#" -eq 1 ]; then
    local status="$1"
    echo "${status}" >"${__IMOSH_CORE_TMPDIR}/status"

    # First, kill all the childs of the current process so that no child
    # processes spawn new processes.
    __sub::exit
    # Then, try to kill other processes under the root process except this
    # process.
    __sub::exit "${IMOSH_ROOT_PID}"
    # Send a TERM signal to the root process.
    kill -TERM "${IMOSH_ROOT_PID}" 2>/dev/null || true
    # Exit immediately.
    exit "${status}"
  else
    LOG FATAL "Wrong number of aruments: $#"
  fi
}
