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

    local PID=''
    func::getmypid PID
    # First, kill all the childs of the current process so that no child
    # processes spawn new processes.
    __imosh::kill "${PID}"
    # Then, try to kill other processes under the root process except this
    # process.
    __imosh::kill "${IMOSH_ROOT_PID}"
    # Send a TERM signal to the root process.
    kill -TERM "${IMOSH_ROOT_PID}" 2>/dev/null || true
    # Exit immediately.
    exit "${status}"
  else
    LOG FATAL "Wrong number of aruments: $#"
  fi
}

# __imosh::kill
#
# Usage:
#   void __imosh::kill(int pid)
#
# __imosh::kill must not be called by functions other than imosh::exit because
# a killer process `PID` must not be stopped by a signal.
__imosh::kill() {
  if [ "$#" -eq 1 ]; then
    local target_pid="$1"
    LOG INFO "killing ${target_pid}..."
    local keep_alive=0
    if [ "${target_pid}" = "${PID}" -o \
         "${target_pid}" = "${IMOSH_ROOT_PID}" ]; then
      keep_alive=1
    fi
    if (( ! keep_alive )); then
      kill -STOP "${target_pid}" 2>/dev/null || true
    fi
    export IFS=$' \t\n'
    local child_pids="$(ps -o ppid,pid | \
                        grep "^[[:space:]]*${target_pid}[[:space:]]" | \
                        awk '{ print $2 }')"
    if [ "${child_pids}" != '' ]; then
      LOG INFO "Target PID (${target_pid})'s child PIDs are: ${child_pids[*]}"
      local child=''
      for child in ${child_pids}; do
        __imosh::kill "${child}"
      done
    else
      LOG INFO "Target PID (${target_pid}) has no child PIDs."
    fi
    if (( ! keep_alive )); then
      kill -KILL "${target_pid}" 2>/dev/null || true
    fi
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}
