# FAILURE -- Declares a test case failed.
#
# FAILURE sets the test case as failed and shows a stack trace.
#
# Usage:
#     void FAILURE()
FAILURE() {
  IMOSH_TEST_IS_FAILED=1
  imosh::stack_trace --skip_imosh '*** Check failure ***'
}

__ASSERT() {
  local last_state="${IMOSH_TEST_IS_FAILED}"
  IMOSH_TEST_IS_FAILED=0
  "$@"
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
  IMOSH_TEST_IS_FAILED="${last_state}"
}
