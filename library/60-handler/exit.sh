imosh::internal::exit_handler() {
  local exit_code="$?"
  if (( exit_code && ! __IMOSH_STACK_TRACED )); then
    imosh::stack_trace "error status: ${exit_code}"
  fi

  local pid=''
  func::getmypid pid
  if [ "${pid}" != "${IMOSH_ROOT_PID}" ]; then
    LOG INFO 'finalizing a child process...'
    return
  fi

  LOG INFO 'finalizing...'

  set +e
  if [ -f "${__IMOSH_CORE_TMPDIR}/atexit.sh" ]; then
    source "${__IMOSH_CORE_TMPDIR}/atexit.sh"
  fi
  rm -rf "${__IMOSH_CORE_TMPDIR}"

  # Close log pipes and remove unused log files.
  exec 101>&- 102>&- 103>&- 104>&-
  local severity=''
  for severity in INFO WARNING ERROR FATAL; do
    local path="$(imosh::internal::log_file "${severity}")"
    if [ "${path}" != '' -a ! -s "${path}" ]; then
      rm "${path}"
    fi
  done
}

trap imosh::internal::exit_handler EXIT
