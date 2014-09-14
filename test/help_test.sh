run() {
  IMOSH_FLAGS_alsologtostderr=0 IMOSH_FLAGS_logtostderr=0 \
  IMOSH_FLAGS_disown_php=0 \
      bash test/flags.sh "$@"
}

test::help() {
  local pids=()
  local expected_message="USAGE: flags.sh [options...] [args...]

DESCRIPTION:
  A script to test imosh flags.

OPTIONS:
  MAIN OPTIONS:
    --bool=false: Boolean flag.
    --disown_php=false: Disown a PHP process.
    --flag='': Flag name to show.
    --int=100: Integer flag.
    --show_argv=false: Output extra argv.
    --string='default': String flag.
  IMOSH OPTIONS:
    --alsologtostderr=false: Log messages go to stderr in addition to logfiles.
    --help=false: Print this help message and exit. (Alias: --h)
    --logtostderr=false: Log messages go to stderr instead of logfiles."
  ASSERT_EQ "${expected_message}" "$(run --help 2>&1 >/dev/null)" &
  pids+=("$!")
  ASSERT_EQ "${expected_message}" "$(run -h 2>&1 >/dev/null)" &
  pids+=("$!")

  # There should be no output to the standard output.
  ASSERT_EQ '' "$(run --help 2>/dev/null)" &
  pids+=("$!")

  for pid in "${pids[@]}"; do
    if ! wait "${pid}"; then
      IMOSH_TEST_IS_FAILED=1
    fi
  done
}
