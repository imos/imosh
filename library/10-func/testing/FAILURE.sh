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
