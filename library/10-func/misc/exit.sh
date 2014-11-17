# exit, die -- Kills the current script.
#
# sub::exit kills all the subprocesses of the current program.  If an integer
# argument is given, sub::exit exits with the status.  Otherwise, sub::exit
# shows the given message and exits with status 0.  sub::die shows a stack
# trace and delegates arguments to sub::exit.
#
# Usage:
#     // 1-a. Command form with a message.
#     void sub::exit(string message)
#     // 1-b. Command form with a status.
#     void sub::exit(int status = 0)
#     // 1-c. Command form with a message.
#     void sub::die(string message)
#     // 1-d. Command form with a status.
#     void sub::die(int status = 0)
sub::exit() {
  if [ "$#" -eq 1 ]; then
    local status=0
    if [[ "$1" =~ ^[0-9]+$ ]]; then
      status="$1"
    else
      local message="$1"
      func::rtrim message
      sub::println "${message}"
    fi
    imosh::exit "${status}"
  elif [ "$#" -eq 0 ]; then
    sub::exit 0
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::die() {
  imosh::stack_trace "*** imosh::die stack trace: ***"
  sub::exit "$@"
}

# __sub::exit -- Kills subprocesses.
#
# __sub::exit kills pid's subprocesses.
#
# Usage:
#     void __sub::exit::kill(int pid = $$, int caller_pid = $$)
__sub::exit() {
  if [ "$#" -eq 2 ]; then
    LOG INFO "killing ${1}..."
    if [ "${1}" != "${2}" -a "${1}" != "${IMOSH_ROOT_PID}" ]; then
      kill -STOP "${1}" 2>/dev/null || true
    fi
    local tmpfile=''
    local ppid=0
    local pid=0
    func::tmpfile tmpfile
    ps -o ppid,pid > "${tmpfile}"
    while IFS=$' \t\n' read -r ppid pid; do
      if [ "${ppid}" != "${1}" ]; then
        __sub::exit "${pid}" "${2}"
      fi
    done < "${tmpfile}"
    if [ "${1}" != "${2}" -a "${1}" != "${IMOSH_ROOT_PID}" ]; then
      kill -KILL "${1}" 2>/dev/null || true
    fi
  elif [ "$#" -eq 1 ]; then
    local pid=0
    func::getmypid pid
    __sub::exit "${1}" "${pid}"
  elif [ "$#" -eq 0 ]; then
    local pid=0
    func::getmypid pid
    __sub::exit "${pid}" "${pid}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
