get_flag() {
  bash test/flags.sh --show_argv "$@" 2>/dev/null &
  if ! wait $!; then sub::print invalid; fi
}

test::extra_flags() {
  local pids=()
  ASSERT_EQ 'foo' "$(get_flag foo)" &
  pids+=("$!")
  ASSERT_EQ 'foo' "$(get_flag -- foo)" &
  pids+=("$!")
  ASSERT_EQ '-- foo' "$(get_flag -- -- foo)" &
  pids+=("$!")
  ASSERT_EQ '-- -- foo' "$(get_flag -- -- -- foo)" &
  pids+=("$!")
  ASSERT_EQ 'foo bar' "$(get_flag foo -- bar)" &
  pids+=("$!")
  ASSERT_EQ 'foo -- bar' "$(get_flag foo -- -- bar)" &
  pids+=("$!")

  ASSERT_EQ 'invalid' "$(get_flag --foo)" &
  pids+=("$!")
  ASSERT_EQ '--foo' "$(get_flag -- --foo)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
