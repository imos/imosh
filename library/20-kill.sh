IMOSH_ROOT_PID="$$"

imosh::internal::kill() {
  local pid="$1"
  LOG INFO "killing ${pid}..."
  local keep_alive=0
  if [ "${pid}" == "${IMOSH_PID}" -o "${pid}" == "${IMOSH_ROOT_PID}" ]; then
    keep_alive=1
  fi
  if (( ! keep_alive )); then
    kill -STOP "${pid}" 2>/dev/null || true
  fi
  local child_pids="$(
      ps -o ppid,pid | grep "^${pid}[[:space:]]" | awk '{ print $2 }')"
  if [ "${child_pids}" != '' ]; then
    local child
    for child in ${child_pids}; do
      imosh::internal::kill "${child}"
    done
  fi
  if (( ! keep_alive )); then
    kill -KILL "${pid}" 2>/dev/null || true
  fi
}

imosh::quiet_die() {
  local status='0'
  if [ "$#" -ge 1 ]; then
    status="$1"
  fi

  echo "${status}" >"${__IMOSH_CORE_TMPDIR}/status"
  LOG INFO 'exiting...'
  imosh::set_pid
  kill -TERM "${IMOSH_ROOT_PID}"
  if [ "${IMOSH_PID}" == "${IMOSH_ROOT_PID}" ]; then
    exit 0
  fi
  for i in {1..20}; do
    if ! kill -0 "${IMOSH_ROOT_PID}" 2>/dev/null; then
      exit 0
    fi
    sleep 0.05
  done
  imosh::internal::kill "${IMOSH_ROOT_PID}"
  exit 0
}

imosh::die() {
  local status='0'
  if [ "$#" -ge 1 ]; then
    status="$1"
  fi

  imosh::stack_trace "*** imosh::die stack trace: ***"
  imosh::quiet_die "${status}"
}
