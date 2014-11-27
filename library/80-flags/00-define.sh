if sub::isset IMOSH_USE_DEFINE_FLAGS && (( IMOSH_USE_DEFINE_FLAGS )); then
  DEFINE_bool --group=imosh --alias=h help false \
      'Print this help message and exit.'
  DEFINE_bool --group=imosh helpfull false \
      'Print all the help message.'
  DEFINE_bool --group=imosh 'alsologtostderr' false \
      'Log messages go to stderr in addition to logfiles.'
  DEFINE_bool --group=imosh 'logtostderr' false \
      'Log messages go to stderr instead of logfiles.'
  DEFINE_string --group=imosh 'log_dir' '' \
      'Directory to output log files.  Output no files if this flag is empty.'
  DEFINE_string --group=imosh 'stacktrace_threshold' 'FATAL' \
      'Threshold to show stacktrace.'
  DEFINE_string --group=imosh 'help_format' '' \
      'Help format to output.'
  DEFINE_string --group=imosh 'imosh_test' '' \
      'Test files to test.'
else
