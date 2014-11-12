# getmypid -- Gets the current process ID.
#
# Usage:
#     // 1. Function form.
#     void func::getmypid(int* variable)
#     // 2. Command form.
#     void sub::getmypid() > output
func::getmypid() {
  if [ "$#" -eq 1 ]; then
    if func::isset BASHPID; then
      func::let "${1}" "${BASHPID}"
    else
      local __getmypid_pid_file=''
      func::tmpfile __getmypid_pid_file
      "${SHELL}" -c 'echo "${PPID}"' > "${__getmypid_pid_file}"
      read -r -d $'\n' "${1}" < "${__getmypid_pid_file}"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::getmypid() {
  if [ "$#" -eq 0 ]; then
    local __getmypid_variable
    func::getmypid __getmypid_variable
    sub::println "${__getmypid_variable}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
