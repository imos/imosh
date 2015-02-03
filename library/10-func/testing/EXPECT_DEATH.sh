# EXPECT_DEATH -- Expects a command unsuccessfully dies.
#
# EXPECT_DEATH expects that a command dies with a non-zero return value.
#
# Usage:
#     void EXPECT_DEATH(string arguments,...)
EXPECT_DEATH() {
  "$@" &
  if wait "$!"; then
    LOG ERROR 'Command did not die unexpectedly:' "$@"
    FAILURE
    return
  fi
  LOG INFO 'Command died as expected:' "$@"
}
