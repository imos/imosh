# ASSERT_DEATH -- Asserts a command unsuccessfully dies.
#
# ASSERT_DEATH asserts that a command dies with a non-zero return value.
#
# Usage:
#     void ASSERT_DEATH(string arguments,...)
ASSERT_DEATH() {
  __ASSERT EXPECT_DEATH "$@"
}
