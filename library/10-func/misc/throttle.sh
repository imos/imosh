# func::throttle -- Throttles by the number of child processes.
#
# Usage:
#   func::throttle(int limit)
func::throttle() {
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
}
