__imosh::exit_handler::atexit() {
  # Stop checking exit statuses because this is inside exit_handler, and it is
  # impossible to output a stacktrace for an irregular exit status.
  set +e
  if [ -f "${__IMOSH_CORE_TMPDIR}/atexit.sh" ]; then
    source "${__IMOSH_CORE_TMPDIR}/atexit.sh"
  fi
}

__imosh::exit_handler() {
  local exit_code="$?"

  # Revert the EXIT trap to prevent an infinite loop.
  trap - EXIT

  # Output a stacktrace if the script does not output a stacktrace for the
  # error.  (signal_handler may output a stacktrace before calling this.)
  if (( exit_code && ! __IMOSH_STACK_TRACED )); then
    imosh::stack_trace "Error status: ${exit_code}"
  fi

  # Check the current process is not the root process so as not to remove the
  # root process's temporary directory.
  local pid=''
  func::getmypid pid
  if [ "${pid}" != "${IMOSH_ROOT_PID}" ]; then
    LOG INFO 'Finalizing a child process...'
    return
  fi

  __imosh::exit_handler::atexit &
  if ! wait "$!"; then
    LOG ERROR 'Failed to run atexit entirely.'
  fi
  rm -R -f "${IMOSH_TMPDIR}"

  # Close log pipes.
  exec 101>&- 102>&- 103>&- 104>&-
}

trap '__imosh::exit_handler' EXIT
