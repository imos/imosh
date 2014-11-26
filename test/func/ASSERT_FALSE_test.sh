run() {
  ASSERT_FALSE "$@" 2>/dev/null
}

test::ASSERT_FALSE() {
  EXPECT_ALIVE run false
  EXPECT_DEATH run true
}
