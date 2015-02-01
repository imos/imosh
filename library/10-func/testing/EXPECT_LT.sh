# EXPECT_LT -- Expects first one is less than second one.
#
# EXPECT_LT expects first one is less than second one.
#
# Usage:
#     void EXPECT_LT(string target, string actual)
#     void EXPECT_STRLT(string target, string actual)
EXPECT_LT() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" -ge "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_LT passes: '$1' < '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STRLT() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" \>= "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_STRLT passes: '$1' < '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

ASSERT_LT() {
  __ASSERT EXPECT_LT "$@"
}

ASSERT_STRLT() {
  __ASSERT EXPECT_STRLT "$@"
}
