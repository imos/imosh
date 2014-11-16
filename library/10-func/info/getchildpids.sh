# getchildpids -- Gets child process IDs.
#
# Usage:
#     // 1. Function form.
#     void func::getchildpids(int[]* variable)
#     // 2. Command form.
#     void sub::getchildpids() > output
func::getchildpids() {
  if [ "$#" -eq 1 ]; then
    local __getchildpids_mypid=''
    func::getmypid __getchildpids_mypid
    local __getchildpids_pid='' __getchildpids_ppid=''
    local __getchildpids_result=()
    while IFS=$' \t\n' \
          read -r -d $'\n' __getchildpids_ppid __getchildpids_pid; do
      if [ "${__getchildpids_ppid}" = "${__getchildpids_mypid}" ]; then
        __getchildpids_result+=("${__getchildpids_pid}")
      fi
    done < <(ps -o ppid,pid)
    func::array_values "${1}" __getchildpids_result
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::getchildpids() {
  if [ "$#" -eq 0 ]; then
    local __getchildpids_variable=()
    func::getchildpids __getchildpids_variable
    sub::implode __getchildpids_variable
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
