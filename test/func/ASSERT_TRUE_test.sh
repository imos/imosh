run() {
  ASSERT_TRUE "$@" 2>'/dev/null' 105>'/dev/null'
}

test::ASSERT_TRUE() {
  EXPECT_ALIVE run true
  EXPECT_DEATH run false
}
