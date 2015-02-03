# DEPRECATED -- Declares as deprecated.
#
# DEPRECATED displays an error message and a stack trace.
#
# Usage:
#     void DEPRECATED()
DEPRECATED() {
  if [ "$#" -eq 0 ]; then
    LOG ERROR "$(imosh::stack_trace 'This is deprecated.' 2>&1)"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
