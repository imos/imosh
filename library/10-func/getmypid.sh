# func::getmypid -- Gets the current process ID.
#
# Usage:
#   func::pid(int* variable)
func::getmypid() {
  local __getmypid_variable="$1"
  if func::isset BASHPID; then
    func::let "${__getmypid_variable}" "${BASHPID}"
  else
    local __getmypid_pid_file="$(mktemp "${__IMOSH_CORE_TMPDIR}/pid.XXXXXX")"
    "${SHELL}" -c 'echo "${PPID}"' >"${__getmypid_pid_file}"
    read "${__getmypid_variable}" <"${__getmypid_pid_file}"
  fi
}
