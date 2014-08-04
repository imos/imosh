run() {
  IMOSH_FLAGS_alsologtostderr=0 IMOSH_FLAGS_logtostderr=0 \
  IMOSH_FLAGS_disown_php=0 \
      bash test/flags.sh "$@"
}

test::help() {
  local pids=()
  local expected_message="Usage: test/flags.sh [options ...] [args ...]
Options:
  --help=false: Print this help message and exit. (Alias: --h)
  --alsologtostderr=false: Log messages go to stderr in addition to logfiles.
  --logtostderr=false: Log messages go to stderr instead of logfiles.
  --disown_php=false: Disown a PHP process.
  --flag='': Flag name to show.
  --show_argv=false: Output extra argv.
  --string='default': String flag.
  --int=100: Integer flag.
  --bool=false: Boolean flag."
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
