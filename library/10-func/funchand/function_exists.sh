# function_exists -- Returns true iff the given function has been defined.
#
# Checks the list of defined functions, both built-in (internal) and
# user-defined, for function_name.
#
# Usage:
#     // 1. Command form.
#     bool sub::function_exists(string function_name)
#
# Examples:
#     EXPECT_TRUE sub::function_exists func::array
sub::function_exists() {
  if [ "$#" -eq 1 ]; then
    if ! type -t "${1}"; then
      return 1
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
