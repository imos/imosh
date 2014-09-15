__IMOSH_STACK_TRACED=0

imosh::on_exit() {
  echo "$@" >>"${__IMOSH_CORE_TMPDIR}/on_exit.sh"
}

imosh::internal::error_handler() {
  __IMOSH_STACK_TRACED=1
  imosh::stack_trace "error status: $?"
}

imosh::internal::exit_handler() {
  local exit_code="$?"
  if (( exit_code && ! __IMOSH_STACK_TRACED )); then
    imosh::stack_trace "error status: ${exit_code}"
  fi
  LOG INFO "finalizing..."

  set +e
  if [ -f "${__IMOSH_CORE_TMPDIR}/on_exit.sh" ]; then
    source "${__IMOSH_CORE_TMPDIR}/on_exit.sh"
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

imosh::internal::signal_handler() {
  local signal="$1"
  LOG ERROR "$(imosh::stack_trace "terminated by signal: ${signal}" 2>&1)"
  trap - "${signal}"
  kill -s "${signal}" $$
}

trap imosh::internal::exit_handler EXIT
trap imosh::internal::error_handler ERR
if ! shopt login_shell >/dev/null; then
  for signal in SIGHUP SIGINT SIGPIPE SIGTERM \
                SIGXCPU SIGXFSZ SIGUSR1 SIGUSR2; do
    trap "imosh::internal::signal_handler ${signal}" "${signal}"
  done
fi
