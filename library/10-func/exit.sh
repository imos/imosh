# func::exit, func::die
#
# Usage:
#   // 1. Message form.
#   void func::exit(string message)
#   // 2. Status form.
#   void func::exit(int status = 0)
#   // 1. Message form.
#   void func::die(string message)
#   // 2. Status form
#   void func::die(int status = 0)
#
# func::exit kills all the subprocesses of the current program.  If an integer
# argument is given, func::exit exists with the status.  Otherwise, func::exit
# shows the given message and exits with status 0.
#
# func::die shows a stack trace and delegates arguments to func::exit.
func::exit() {
  if [ "$#" -eq 0 ]; then
    set -- 0
  fi
  if [ "$#" -le 1 ]; then
    local status=0
    if [[ "$1" =~ ^[0-9]+$ ]]; then
      status="$1"
    else
      local message="$1"
      func::rtrim message
      func::println "${message}"
    fi
    imosh::exit "${status}"
  else
    LOG FATAL "Wrong number of arumnets: $#"
  fi
}

func::die() {
  if [ "$#" -le 1 ]; then
    imosh::stack_trace "*** imosh::die stack trace: ***"
    func::exit "$@"
  else
    LOG ERROR "Wrong number of arguments: $#"
  fi
}
