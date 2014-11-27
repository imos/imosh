run() {
  ASSERT_NE "$@" 2>'/dev/null' 105>'/dev/null'
}

test::ASSERT_NE() {
  EXPECT_ALIVE run 'abc' 'def'
  EXPECT_DEATH run 'abc' 'abc'
}
