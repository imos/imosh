output_log() {
  if (( FLAGS_logtostderr )); then
    FLAGS_alsologtostderr=1
    FLAGS_logtostderr=0
  fi
  __IMOSH_LOGGING=1
  __IMOSH_LOG_PID=12345 LOG "$@"
}

test::log::info() {
  message="$(output_log INFO 'message' 101>&1 2>/dev/null)"
  EXPECT_EQ 'I0000 00:00:00.000000 00000 log_test.sh:0] message' \
            "${message//[0-9]/0}"
}

test::log::warning() {
  message="$(output_log WARNING 'message' \
                 101>/dev/null 102>&1 2>/dev/null)"
  EXPECT_EQ 'W0000 00:00:00.000000 00000 log_test.sh:0] message' \
            "${message//[0-9]/0}"
}

test::log::error() {
  message="$(output_log ERROR 'message' \
                 101>/dev/null 102>/dev/null 103>&1 2>/dev/null)"
  EXPECT_EQ 'E0000 00:00:00.000000 00000 log_test.sh:0] message' \
            "${message//[0-9]/0}"
}
