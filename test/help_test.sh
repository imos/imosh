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
    --flag='': Flag name to show.
    --int=100: Integer flag.
    --show_argv=false: Output extra argv.
    --string='default': String flag.
  IMOSH OPTIONS:
    --alsologtostderr=false: Log messages go to stderr in addition to logfiles.
    --disown_php=false: Disown a PHP process.
    --help=false: Print this help message and exit. (Alias: --h)
    --help_groff=false: Use groff for help output.
    --log_dir='': Directory to output log files.  Output no files if this flag is empty.
    --logtostderr=false: Log messages go to stderr instead of logfiles.
    --stacktrace_threshold='FATAL': Threshold to show stacktrace."
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

test::help_groff() {
  local expected_message='.TH flags.sh 1

.SH DESCRIPTION
A script to test imosh flags.

.SH OPTIONS
.SS MAIN OPTIONS
.TP
\fB--bool=false\fP
Boolean flag.

.TP
\fB--flag='\'\''\fP
Flag name to show.

.TP
\fB--int=100\fP
Integer flag.

.TP
\fB--show_argv=false\fP
Output extra argv.

.TP
\fB--string='\''default'\''\fP
String flag.

.SS IMOSH OPTIONS
.TP
\fB--alsologtostderr=false\fP
Log messages go to stderr in addition to logfiles.

.TP
\fB--disown_php=false\fP
Disown a PHP process.

.TP
\fB--help=false\fP
Print this help message and exit. (Alias: --h)

.TP
\fB--help_groff=false\fP
Use groff for help output.

.TP
\fB--log_dir='\'\''\fP
Directory to output log files.  Output no files if this flag is empty.

.TP
\fB--logtostderr=false\fP
Log messages go to stderr instead of logfiles.

.TP
\fB--stacktrace_threshold='\''FATAL'\''\fP
Threshold to show stacktrace.'
  ASSERT_EQ "${expected_message}" "$(run --help --help_groff)"
}
