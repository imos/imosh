imosh::internal::error_handler() {
  __IMOSH_STACK_TRACED=1
  imosh::stack_trace "error status: $?"
}

trap imosh::internal::error_handler ERR
