imosh::set_pid() {
  if php::isset BASHPID; then
    IMOSH_PID="${BASHPID}"
  else
    local pid_file="$(mktemp "${__IMOSH_CORE_TMPDIR}/pid.XXXXXX")"
    "${SHELL}" -c 'echo "${PPID}"' >"${pid_file}"
    IMOSH_PID="$(cat "${pid_file}")"
  fi
}
