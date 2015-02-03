# EXPECT_TRUE -- Expects a command succeeds.
#
# EXPECT_TRUE expects the command succeeds (returns 0).
#
# Usage:
#     void EXPECT_TRUE(string arguments,...)
EXPECT_TRUE() {
  if ! "$@"; then
    sub::println '  Actual: false' >&2
    sub::println 'Expected: true' >&2
    LOG ERROR 'EXPECT_TRUE failed:' "$@"
    FAILURE
    return
  fi
  LOG INFO 'EXPECT_TRUE passes:' "$@"
}
