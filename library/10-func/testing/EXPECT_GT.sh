# EXPECT_GT -- Expects first one is greater than second one.
#
# EXPECT_GT expects first one is greater than second one.
#
# Usage:
#     void EXPECT_GT(string target, string actual)
#     void EXPECT_STRGT(string target, string actual)
EXPECT_GT() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" -le "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_GT passes: '$1' > '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STRGT() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" \<= "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_STRGT passes: '$1' > '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

ASSERT_GT() {
  __ASSERT EXPECT_GT "$@"
}

ASSERT_STRGT() {
  __ASSERT EXPECT_STRGT "$@"
}
