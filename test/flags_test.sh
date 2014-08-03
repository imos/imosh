get_flag() {
  bash test/flags.sh "$@" 2>/dev/null &
  if ! wait $!; then print invalid; fi
}

test::bool_flag() {
  local pids=()
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool)" &
  pids+=("$!")

  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --nobool)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=false)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=False)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=f)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=F)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=0)" &
  pids+=("$!")

  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=true)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=True)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=t)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=T)" &
  pids+=("$!")
  EXPECT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=1)" &
  pids+=("$!")

  EXPECT_EQ 'invalid' "$(get_flag --flag=bool --bool=invalid)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
