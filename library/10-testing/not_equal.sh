# EXPECT_NE, ASSERT_NE -- Check if two values are not equal.
#
# Usage:
#   bool EXPECT_NE(string expected, string actual)
#   void ASSERT_NE(string expected, string actual)
#
# Aliases:
#   EXPECT_STRNE is an alias of EXPECT_NE, and ASSERT_STRNE is an alias of
#   ASSERT_NE.
EXPECT_NE() {
  if [ "$#" -ne 2 ]; then
    LOG ERROR 'EXPECT_NE requires two arguments.'
    return 1
  fi
  if [ "$1" = "$2" ]; then
    echo "Actual: $2" >&2
    echo "Target: $1" >&2
    FAILURE
    return 1
  fi
  LOG INFO "EXPECT_NE passes: '$1' != '$2'"
}

ASSERT_NE() {
  __ASSERT EXPECT_NE "$@"
}

EXPECT_STRNE() { EXPECT_NE "$@"; }
ASSERT_STRNE() { ASSERT_NE "$@"; }
