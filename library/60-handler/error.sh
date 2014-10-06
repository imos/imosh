__imosh::error_handler() {
  __IMOSH_STACK_TRACED=1
  imosh::stack_trace "error status: $?"
}

trap '__imosh::error_handler' ERR
