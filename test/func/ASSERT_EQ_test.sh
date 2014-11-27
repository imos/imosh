run() {
  ASSERT_EQ "$@" 2>'/dev/null' 105>'/dev/null'
}

test::ASSERT_EQ() {
  EXPECT_ALIVE run 'abc' 'abc'
  EXPECT_DEATH run 'abc' 'def'
}
