CHECK() {
  if ! "$@"; then
    IFS=' ' eval 'imosh::stack_trace "*** Check failure: $* ***"'
  fi
}
