# ASSERT_EQ -- Asserts two arguments are equal.
#
# ASSERT_EQ asserts two arguments are equal.
#
# Usage:
#     void ASSERT_EQ(string expected, string actual)
#
# Alias:
#   ASSERT_STREQ is an alias of ASSERT_EQ.
ASSERT_EQ() {
  __ASSERT EXPECT_EQ "$@"
}

ASSERT_STREQ() {
  ASSERT_EQ "$@"
}
