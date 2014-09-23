# EXPECT_EQ, ASSERT_EQ -- Check if two values are equal.
#
# Usage:
#   bool EXPECT_EQ(string expected, string actual)
#   void ASSERT_EQ(string expected, string actual)
#
# Aliases:
#   EXPECT_STREQ is an alias of EXPECT_EQ, and ASSERT_STREQ is an alias of
#   ASSERT_EQ.
EXPECT_EQ() {
  if [ "$#" -ne 2 ]; then
    LOG ERROR 'EXPECT_EQ requires two arguments.'
    return 1
  fi
  if [ "$1" != "$2" ]; then
    echo "  Actual: $2" >&2
    echo "Expected: $1" >&2
    FAILURE
    return 1
  fi
}

ASSERT_EQ() {
  ASSERT EXPECT_EQ "$@"
}

EXPECT_STREQ() { EXPECT_EQ "$@"; }
ASSERT_STREQ() { ASSERT_EQ "$@"; }
