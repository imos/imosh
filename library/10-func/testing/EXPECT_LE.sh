# EXPECT_LE -- Expects first one is less than or equal to second one.
#
# EXPECT_LE expects first one is less than or equal to second one.
#
# Usage:
#     void EXPECT_LE(string target, string actual)
#     void EXPECT_STRLE(string target, string actual)
EXPECT_LE() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" -gt "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_LE passes: '$1' <= '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STRLE() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" \> "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_STRLE passes: '$1' <= '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

ASSERT_LE() {
  __ASSERT EXPECT_LE "$@"
}

ASSERT_STRLE() {
  __ASSERT EXPECT_STRLE "$@"
}
