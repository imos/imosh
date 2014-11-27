# ASSERT_NE -- Asserts two arguments are not equal.
#
# ASSERT_NE asserts two arguments are not equal.
#
# Usage:
#     void ASSERT_NE(string target, string actual)
#
# Alias:
#   ASSERT_STRNE is an alias of ASSERT_NE.
ASSERT_NE() {
  __ASSERT EXPECT_NE "$@"
}

ASSERT_STRNE() {
  ASSERT_NE "$@"
}
