get_flag() {
  if ! bash test/flags.sh "$@" 2>/dev/null; then
    sub::print invalid
  fi
}

run_testcase() {
  local expected="$1"; shift
  local flags=("$@")

  sub::throttle 4
  ASSERT_EQ "${expected}" "$(get_flag "${flags[@]}")" &
  pids+=("$!")
}

test::bool_flag() {
  local pids=()

  run_testcase 'FLAGS_bool=0' --flag=bool

  run_testcase 'FLAGS_bool=0' --flag=bool --nobool
  run_testcase 'FLAGS_bool=0' --flag=bool --bool=false
  run_testcase 'FLAGS_bool=0' --flag=bool --bool=False
  run_testcase 'FLAGS_bool=0' --flag=bool --bool=f
  run_testcase 'FLAGS_bool=0' --flag=bool --bool=F
  run_testcase 'FLAGS_bool=0' --flag=bool --bool=0

  run_testcase 'FLAGS_bool=1' --flag=bool --bool
  run_testcase 'FLAGS_bool=1' --flag=bool --bool=true
  run_testcase 'FLAGS_bool=1' --flag=bool --bool=True
  run_testcase 'FLAGS_bool=1' --flag=bool --bool=t
  run_testcase 'FLAGS_bool=1' --flag=bool --bool=T
  run_testcase 'FLAGS_bool=1' --flag=bool --bool=1

  run_testcase 'invalid' --flag=bool --bool=invalid

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}

test::int_flag() {
  local pids=()

  run_testcase 'FLAGS_int=100' --flag=int

  run_testcase 'FLAGS_int=0' --flag=int --int=0
  run_testcase 'FLAGS_int=12345' --flag=int --int=12345
  run_testcase 'FLAGS_int=-12345' --flag=int --int=-12345
  run_testcase 'FLAGS_int=012345' --flag=int --int=012345

  run_testcase 'FLAGS_int=0' --flag=int --int 0
  run_testcase 'FLAGS_int=12345' --flag=int --int 12345
  run_testcase 'FLAGS_int=-12345' --flag=int --int -12345
  run_testcase 'FLAGS_int=012345' --flag=int --int 012345

  run_testcase 'invalid' --flag=int --int
  run_testcase 'invalid' --flag=int --int=abc

  run_testcase 'invalid' --flag=int --int
  run_testcase 'invalid' --flag=int --int abc

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}

test::string_flag() {
  local pids=()

  run_testcase 'FLAGS_string=default' --flag=string

  run_testcase 'FLAGS_string=' --flag=string --string=
  run_testcase 'FLAGS_string=abc' --flag=string --string=abc

  run_testcase 'FLAGS_string=' --flag=string --string ''
  run_testcase 'FLAGS_string=abc' --flag=string --string abc

  run_testcase 'invalid' --flag=string --string

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
