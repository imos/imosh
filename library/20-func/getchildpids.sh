# func::getchildpids -- Gets child process IDs.
#
# Usage:
#   func::getchildpids(int[]* variable)
func::getchildpids() {
  local __getchildpids_variable="$1"
  local __getchildpids_mypid=''
  func::getmypid __getchildpids_mypid
  local __getchildpids_pid='' __getchildpids_ppid=''
  local __getchildpids_result=()
  while IFS=$' \t\n' read -r -d $'\n' __getchildpids_ppid __getchildpids_pid; do
    if [ "${__getchildpids_ppid}" = "${__getchildpids_mypid}" ]; then
      __getchildpids_result+=("${__getchildpids_pid}")
    fi
  done <<<"$(ps -o ppid,pid)"
  if [ "${#__getchildpids_result[*]}" -eq 0 ]; then
    eval "${__getchildpids_variable}=()"
  else
    eval "${__getchildpids_variable}=(\"\${__getchildpids_result[@]}\")"
  fi
}
