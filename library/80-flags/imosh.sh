DEFINE_bool --group=imosh --alias=h help false \
    'Print this help message and exit.'
DEFINE_bool --group=imosh 'alsologtostderr' false \
    'Log messages go to stderr in addition to logfiles.'
DEFINE_bool --group=imosh 'logtostderr' false \
    'Log messages go to stderr instead of logfiles.'
DEFINE_string --group=imosh 'log_dir' '' \
    'Directory to output log files.  Output no files if this flag is empty.'
DEFINE_string --group=imosh 'stacktrace_threshold' 'FATAL' \
    'Threshold to show stacktrace.'
DEFINE_bool --group=imosh 'help_groff' false \
    'Use groff for help output.'