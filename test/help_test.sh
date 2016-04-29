run() {
  IMOSH_FLAGS_alsologtostderr=0 IMOSH_FLAGS_logtostderr=0 \
  IMOSH_FLAGS_disown_php=0 \
      bash test/flags.sh "$@"
}

test::help() {
  local pids=()
  local expected_message="A script to test imosh flags.

OPTIONS:
  MAIN OPTIONS:
    --bool=false
        Boolean flag.
    --enum=bar
        Enum flag.
    --flag=''
        Flag name to show.
    --int=100
        Integer flag. (Alias: --i)
    --list=a,b,c
        Multiple strings flag.
    --multiint=1,10,100
        Multiple integers flag. (Alias: --m)
    --show_argv=false
        Output extra argv.
    --string=default
        String flag."
  ASSERT_EQ "${expected_message}" "$(run --help 2>&1)" &
  pids+=("$!")
  ASSERT_EQ "${expected_message}" "$(run -h 2>&1)" &
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
\fB--enum=bar\fP
Enum flag.

.TP
\fB--flag='\'\''\fP
Flag name to show.

.TP
\fB--int=100\fP
Integer flag. (Alias: --i)

.TP
\fB--list=a,b,c\fP
Multiple strings flag.

.TP
\fB--multiint=1,10,100\fP
Multiple integers flag. (Alias: --m)

.TP
\fB--show_argv=false\fP
Output extra argv.

.TP
\fB--string=default\fP
String flag.'
  ASSERT_EQ "${expected_message}" "$(run --help_format=groff 2>&1)"
}

test::help_markdown() {
  local expected_message='A script to test imosh flags.

# Options
## main options
* --bool=false
    * Boolean flag.
* --enum=bar
    * Enum flag.
* --flag='\'\''
    * Flag name to show.
* --int=100
    * Integer flag. (Alias: --i)
* --list=a,b,c
    * Multiple strings flag.
* --multiint=1,10,100
    * Multiple integers flag. (Alias: --m)
* --show_argv=false
    * Output extra argv.
* --string=default
    * String flag.'
  ASSERT_EQ "${expected_message}" "$(run --help_format=markdown 2>&1)"
}
