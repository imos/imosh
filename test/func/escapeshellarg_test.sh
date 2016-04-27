test::func_escapeshellarg() {
  local variable

  variable=''
  func::escapeshellarg variable
  EXPECT_EQ "''" "${variable}"

  variable='test'
  func::escapeshellarg variable
  EXPECT_EQ "test" "${variable}"

  variable='abc,01234-foo.bar/baz'
  func::escapeshellarg variable
  EXPECT_EQ "abc,01234-foo.bar/baz" "${variable}"

  variable="abc def'ghi\\jkl"
  func::escapeshellarg variable
  EXPECT_EQ "'abc def'\\''ghi\\jkl'" "${variable}"
}
