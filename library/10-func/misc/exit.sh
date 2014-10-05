# exit, die -- Kills the current script.
#
# func::exit kills all the subprocesses of the current program.  If an integer
# argument is given, func::exit exits with the status.  Otherwise, func::exit
# shows the given message and exits with status 0.  func::die shows a stack
# trace and delegates arguments to func::exit.
#
# Usage:
#     // 1-a. Function form with a message.
#     void func::exit(string message)
#     // 1-b. Function form with a status.
#     void func::exit(int status = 0)
#     // 1-c. Function form with a message.
#     void func::die(string message)
#     // 1-d. Function form with a status.
#     void func::die(int status = 0)
func::exit() {
  if [ "$#" -eq 1 ]; then
    local status=0
    if [[ "$1" =~ ^[0-9]+$ ]]; then
      status="$1"
    else
      local message="$1"
      func::rtrim message
      func::println "${message}"
    fi
    imosh::exit "${status}"
  elif [ "$#" -eq 0 ]; then
    func::exit 0
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}

func::die() {
  imosh::stack_trace "*** imosh::die stack trace: ***"
  func::exit "$@"
}
