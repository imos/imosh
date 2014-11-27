# EXPECT_ALIVE -- Expects a command successfully exits.
#
# EXPECT_ALIVE expects that a command exits with a zero return value.
#
# Usage:
#     void EXPECT_ALIVE(string arguments,...)
EXPECT_ALIVE() {
  "$@" &
  if ! wait "$!"; then
    LOG ERROR 'Command died unexpectedly:' "$@"
    FAILURE
    return
  fi
  LOG INFO 'Command did not die as expected:' "$@"
}
