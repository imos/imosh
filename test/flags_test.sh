get_flag() {
  bash test/flags.sh "$@" 2>/dev/null &
  if ! wait $!; then print invalid; fi
}

test::bool_flag() {
  local pids=()
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --nobool)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=false)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=False)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=f)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=F)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=0' "$(get_flag --flag=bool --bool=0)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=true)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=True)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=t)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=T)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_bool=1' "$(get_flag --flag=bool --bool=1)" &
  pids+=("$!")

  ASSERT_EQ 'invalid' "$(get_flag --flag=bool --bool=invalid)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}

test::int_flag() {
  local pids=()
  ASSERT_EQ 'FLAGS_int=100' "$(get_flag --flag=int)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_int=0' "$(get_flag --flag=int --int=0)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=12345' "$(get_flag --flag=int --int=12345)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=-12345' "$(get_flag --flag=int --int=-12345)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=012345' "$(get_flag --flag=int --int=012345)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_int=0' "$(get_flag --flag=int --int 0)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=12345' "$(get_flag --flag=int --int 12345)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=-12345' "$(get_flag --flag=int --int -12345)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_int=012345' "$(get_flag --flag=int --int 012345)" &
  pids+=("$!")

  ASSERT_EQ 'invalid' "$(get_flag --flag=int --int)" &
  pids+=("$!")
  ASSERT_EQ 'invalid' "$(get_flag --flag=int --int=abc)" &
  pids+=("$!")

  ASSERT_EQ 'invalid' "$(get_flag --flag=int --int)" &
  pids+=("$!")
  ASSERT_EQ 'invalid' "$(get_flag --flag=int --int abc)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}

test::string_flag() {
  local pids=()
  ASSERT_EQ 'FLAGS_string=default' "$(get_flag --flag=string)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_string=' "$(get_flag --flag=string --string=)" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_string=abc' "$(get_flag --flag=string --string=abc)" &
  pids+=("$!")

  ASSERT_EQ 'FLAGS_string=' "$(get_flag --flag=string --string '')" &
  pids+=("$!")
  ASSERT_EQ 'FLAGS_string=abc' "$(get_flag --flag=string --string abc)" &
  pids+=("$!")

  ASSERT_EQ 'invalid' "$(get_flag --flag=string --string)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
