# CHECK - checks if a command succeeds.
#
# CHECK fails with a fatal error if a command fails.
#
# Usage:
#     void CHECK(string command...)
CHECK() {
  IFS=' ' eval 'local __CHECK_message="Check failure: $*"'
  if [ "$#" -ge 1 ] && [ "${1:0:10}" = '--message=' ]; then
    __CHECK_message="${1:10}"
    shift
  fi

  if [ "$#" -ge 1 ]; then
    local __CHECK_invert="${1}"

    if [ "${__CHECK_invert}" = '!' ]; then
      shift
      if "$@"; then
        IFS=' ' eval 'LOG ERROR "Check failure: ! $*"'
        LOG FATAL "${__CHECK_message}"
      fi
    else
      if ! "$@"; then
        IFS=' ' eval 'LOG ERROR "Check failure: $*"'
        LOG FATAL "${__CHECK_message}"
      fi
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
