# ASSERT -- Asserts a command succeeds.
#
# ASSERT checks if a command returns 0.
#
# Usage:
#     void ASSERT(string args,...)
ASSERT() {
  local last_state="${IMOSH_TEST_IS_FAILED}"
  IMOSH_TEST_IS_FAILED=0
  "$@"
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
  IMOSH_TEST_IS_FAILED="${last_state}"
}
