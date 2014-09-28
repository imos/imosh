imosh::internal::signal_handler() {
  local signal="$1"
  trap - "${signal}"
  local PID=''
  func::getmypid PID
  if [ "${PID}" == "${IMOSH_ROOT_PID}" ]; then
    LOG INFO 'killing child processes.'
    __imosh::kill "${IMOSH_ROOT_PID}"
    if [ -f "${__IMOSH_CORE_TMPDIR}/status" ]; then
      exit "$(cat "${__IMOSH_CORE_TMPDIR}/status")"
    fi
  fi
  LOG ERROR "$(imosh::stack_trace "terminated by signal: ${signal}" 2>&1)"
  kill -s "${signal}" "${PID}"
}

if ! shopt login_shell >/dev/null; then
  for signal in SIGHUP SIGINT SIGPIPE SIGTERM \
                SIGXCPU SIGXFSZ SIGUSR1 SIGUSR2; do
    trap "imosh::internal::signal_handler ${signal}" "${signal}"
  done
fi
