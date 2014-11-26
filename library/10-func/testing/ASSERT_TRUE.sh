# ASSERT_TRUE -- Asserts a command succeeds.
#
# ASSERT_TRUE asserts the command succeeds (returns 0).
#
# Usage:
#     void ASSERT_TRUE(string arguments,...)
ASSERT_TRUE() {
  ASSERT EXPECT_TRUE "$@"
}
