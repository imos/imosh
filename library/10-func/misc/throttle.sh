# throttle -- Throttles by the number of child processes.
#
# throttle waits that the number of the child processes is less than a limit.
# Firstly, throttle waits for 0.1 second, and the n-th retry (n < 10) waits for
# n * 0.1 seconds.  The n-th retry (n >= 10) waits for 1 second.
#
# Usage:
#     void sub::throttle(int limit)
sub::throttle() {
  if [ "$#" -eq 1 ]; then
    local pids=()
    local sleep=0

    while :; do
      func::getchildpids pids
      if [ "${#pids[*]}" -lt "${1}" ]; then
        break
      fi
      if (( sleep += 1, sleep < 10 )); then
        sleep "0.${sleep}"
      else
        sleep 1
      fi
    done
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
