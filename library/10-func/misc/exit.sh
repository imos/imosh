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
