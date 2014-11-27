# EXPECT_EQ -- Expects two arguments are equal.
#
# EXPECT_EQ expects two arguments are equal.
#
# Usage:
#     void EXPECT_EQ(string expected, string actual)
#
# Alias:
#   EXPECT_STREQ is an alias of EXPECT_EQ.
EXPECT_EQ() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" != "$2" ]; then
      echo "  Actual: $2" >&2
      echo "Expected: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_EQ passes: '$1' == '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STREQ() {
  EXPECT_EQ "$@"
}
