# ASSERT_FALSE -- Expects a command fails.
#
# ASSERT_FALSE expects the command fails (returns a non-zero value).
#
# Usage:
#     void ASSERT_FALSE(string arguments,...)
ASSERT_FALSE() {
  __ASSERT EXPECT_FALSE "$@"
}
