test::help() {
  local pids=()
  local expected_message="Usage: test/flags.sh [options ...] [args ...]
Options:
  --help=false: Print this help message and exit. (Alias: --h)
  --flag='': Flag name to show.
  --string='default': String flag.
  --int=100: Integer flag.
  --bool=false: Boolean flag."
  EXPECT_EQ "${expected_message}" \
            "$(bash test/flags.sh --help 2>&1 >/dev/null)" &
  pids+=("$!")
  EXPECT_EQ "${expected_message}" \
            "$(bash test/flags.sh -h 2>&1 >/dev/null)" &
  pids+=("$!")

  # There should be no output to the standard output.
  EXPECT_EQ '' "$(bash test/flags.sh --help 2>/dev/null)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
