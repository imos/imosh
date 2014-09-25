FAILURE() {
  IMOSH_TEST_IS_FAILED=1
  imosh::stack_trace --skip_imosh '*** Check failure ***'
}
