CHECK() {
  local __CHECK_invert="$1"

  if [ "${__CHECK_invert}" = '!' ]; then
    shift
    if "$@"; then
      IFS=' ' eval 'imosh::stack_trace "*** Check failure: ! $* ***"'
    fi
  else
    if ! "$@"; then
      IFS=' ' eval 'imosh::stack_trace "*** Check failure: $* ***"'
    fi
  fi
}
