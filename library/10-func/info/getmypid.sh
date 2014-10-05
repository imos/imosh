# func::getmypid -- Gets the current process ID.
#
# Usage:
#     void func::pid(int* variable)
func::getmypid() {
  if [ "$#" -eq 1 ]; then
    local __getmypid_variable="$1"
    if func::isset BASHPID; then
      func::let "${__getmypid_variable}" "${BASHPID}"
    else
      local __getmypid_pid_file=''
      func::tmpfile __getmypid_pid_file
      "${SHELL}" -c 'echo "${PPID}"' > "${__getmypid_pid_file}"
      read -r -d $'\n' "${__getmypid_variable}" < "${__getmypid_pid_file}"
    fi
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
