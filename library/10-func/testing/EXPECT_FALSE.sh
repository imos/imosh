# EXPECT_FALSE -- Expects a command fails.
#
# EXPECT_FALSE expects the command fails (returns a non-zero value).
#
# Usage:
#     void EXPECT_FALSE(string arguments,...)
EXPECT_FALSE() {
  if "$@"; then
    sub::println '  Actual: true' >&2
    sub::println 'Expected: false' >&2
    LOG ERROR 'EXPECT_FALSE failed:' "$@"
    FAILURE
    return
  fi
  LOG INFO 'EXPECT_FALSE passes:' "$@"
}
