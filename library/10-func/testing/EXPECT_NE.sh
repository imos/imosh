# EXPECT_NE -- Expects two arguments are not equal.
#
# EXPECT_NE expects two arguments are not equal.
#
# Usage:
#     void EXPECT_NE(string target, string actual)
#
# Alias:
#   EXPECT_STRNE is an alias of EXPECT_NE.
EXPECT_NE() {
  if [ "$#" -eq 2 ]; then
    if [ "$1" = "$2" ]; then
      echo "Actual: $2" >&2
      echo "Target: $1" >&2
      FAILURE
    fi
    LOG INFO "EXPECT_NE passes: '$1' != '$2'"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

EXPECT_STRNE() {
  EXPECT_NE "$@"
}
