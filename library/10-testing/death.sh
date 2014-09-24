# EXPECT_DEATH, EXPECT_ALIVE, ASSERT_DEATH, ASSERT_ALIVE
#
# Usage:
#   bool EXPECT_DEATH(string arguments...)
#   bool EXPECT_ALIVE(string arguments...)
#   void ASSERT_DEATH(string arguments...)
#   void ASSERT_ALIVE(string arguments...)
EXPECT_DEATH() {
  "$@" &
  if wait "$!"; then
    IFS=' ' eval 'LOG ERROR "Command did not die unexpectedly: $*"'
    return 1
  fi
  IFS=' ' eval 'LOG INFO "Command died as expected: $*"'
}

EXPECT_ALIVE() {
  "$@" &
  if ! wait "$!"; then
    IFS=' ' eval 'LOG ERROR "Command died unexpectedly: $*"'
    return 1
  fi
  IFS=' ' eval 'LOG INFO "Command did not die as expected: $*"'
}

ASSERT_DEATH() { ASSERT EXPECT_DEATH "$@"; }
ASSERT_ALIVE() { ASSERT EXPECT_ALIVE "$@"; }
