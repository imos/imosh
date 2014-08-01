test::log::info() {
  message="$(LOG INFO 'message' 2>&1)"
  EXPECT_EQ 'I0000 00:00:00.000000 00000 test/log_test.sh:0] message' \
            "${message//[0-9]/0}"
}

test::log::warning() {
  message="$(LOG WARNING 'message' 2>&1)"
  EXPECT_EQ 'W0000 00:00:00.000000 00000 test/log_test.sh:0] message' \
            "${message//[0-9]/0}"
}

test::log::error() {
  message="$(LOG ERROR 'message' 2>&1)"
  EXPECT_EQ 'E0000 00:00:00.000000 00000 test/log_test.sh:00] message' \
            "${message//[0-9]/0}"
}
