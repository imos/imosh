imosh::on_exit() {
  echo "$@" >>"${__IMOSH_TMPDIR}/on_exit.sh"
}

imosh::internal::error_handler() {
  imosh::stack_trace "error status: $?"
}

imosh::internal::exit_handler() {
  set +e
  if [ -f "${__IMOSH_TMPDIR}/on_exit.sh" ]; then
    source "${__IMOSH_TMPDIR}/on_exit.sh"
  fi
  rm -rf "${__IMOSH_TMPDIR}"
}

imosh::internal::signal_handler() {
  local signal="$1"
  imosh::stack_trace "terminated by signal: ${signal}"
  trap - "${signal}"
  kill -s "${signal}" $$
  # exit 130
}

trap imosh::internal::exit_handler EXIT
trap imosh::internal::error_handler ERR
for signal in SIGHUP SIGINT SIGPIPE SIGTERM SIGXCPU SIGXFSZ SIGUSR1 SIGUSR2; do
  trap "imosh::internal::signal_handler ${signal}" "${signal}"
done
