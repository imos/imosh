# ASSERT_ALIVE -- Asserts a command successfully dies.
#
# ASSERT_ALIVE asserts that a command dies with a zero return value.
#
# Usage:
#     void ASSERT_ALIVE(string arguments,...)
ASSERT_ALIVE() {
  __ASSERT EXPECT_ALIVE "$@"
}
