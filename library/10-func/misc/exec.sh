# exec -- Executes an external program.
#
# func::exec executes an external program and sets its output to the variable.
#
# Usage:
#     // Function form.
#     void func::exec(string* output, string arguments...)
func::exec() {
  if [ "$#" -gt 1 ]; then
    local __func_exec_variable="${1}"
    shift
    local __func_exec_output=''
    func::tmpfile __func_exec_output
    "$@" >"${__func_exec_output}"
    func::file_get_contents "${__func_exec_variable}" "${__func_exec_output}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
