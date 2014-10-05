# func::throttle -- Throttles by the number of child processes.
#
# throttle waits that the number of the child processes is less than a limit.
# Firstly, throttle waits for 0.1 second, and the n-th retry (n < 10) waits for
# n * 0.1 seconds.  The n-th retry (n >= 10) waits for 1 second.
#
# Usage:
#     void func::throttle(int limit)
func::throttle() {
  if [ "$#" -eq 1 ]; then
    local __throttle_limit="$1"
    local __throttle_pids=()
    local __throttle_sleep=0

    while :; do
      func::getchildpids __throttle_pids
      if [ "${#__throttle_pids[*]}" -lt "${__throttle_limit}" ]; then
        break
      fi
      if (( __throttle_sleep += 1, __throttle_sleep < 10 )); then
        sleep "0.${__throttle_sleep}"
      else
        sleep 1
      fi
    done
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
