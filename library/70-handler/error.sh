__imosh::error_handler() {
  local exit_code="$?"
  __IMOSH_STACK_TRACED=1
  imosh::stack_trace "error status: ${exit_code}"
}

trap '__imosh::error_handler' ERR
