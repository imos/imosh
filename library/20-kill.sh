imosh::internal::kill() {
  local target_pid="$1"
  LOG INFO "killing ${target_pid}..."
  local keep_alive=0
  if [ "${target_pid}" == "${PID}" -o \
       "${target_pid}" == "${IMOSH_ROOT_PID}" ]; then
    keep_alive=1
  fi
  if (( ! keep_alive )); then
    kill -STOP "${target_pid}" 2>/dev/null || true
  fi
  local child_pids="$(
      ps -o ppid,pid | grep "^${target_pid}[[:space:]]" | awk '{ print $2 }')"
  if [ "${child_pids}" != '' ]; then
    local child
    for child in ${child_pids}; do
      imosh::internal::kill "${child}"
    done
  fi
  if (( ! keep_alive )); then
    kill -KILL "${target_pid}" 2>/dev/null || true
  fi
}

imosh::quiet_die() {
  local status='0'
  if [ "$#" -ge 1 ]; then
    status="$1"
  fi

  LOG INFO 'exiting...'
  local PID=''
  func::getmypid PID
  echo "${status}" >"${__IMOSH_CORE_TMPDIR}/status"
  imosh::internal::kill "${PID}"
  imosh::internal::kill "${IMOSH_ROOT_PID}"
  kill -TERM "${IMOSH_ROOT_PID}" 2>/dev/null || true
  exit "${status}"
}

imosh::die() {
  local status='0'
  if [ "$#" -ge 1 ]; then
    status="$1"
  fi

  imosh::stack_trace "*** imosh::die stack trace: ***"
  imosh::quiet_die "${status}"
}
