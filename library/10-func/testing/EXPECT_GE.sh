# EXPECT_GE -- Expects first one is greater than or equal to second one.
#
# EXPECT_GE expects first one is greater than or equal to second one.
#
# Usage:
#     void EXPECT_GE(string target, string actual)
#     void EXPECT_STRGE(string target, string actual)
EXPECT_GE() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" -lt "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_GE passes: '$1' >= '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STRGE() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" \< "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_STRGE passes: '$1' >= '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

ASSERT_GE() {
  __ASSERT EXPECT_GE "$@"
}

ASSERT_STRGE() {
  __ASSERT EXPECT_STRGE "$@"
}
