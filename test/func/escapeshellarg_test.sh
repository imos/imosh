test::func_escapeshellarg() {
  local variable

  variable='test'
  func::escapeshellarg variable
  EXPECT_EQ "'test'" "${variable}"

  variable="abc def'ghi\\jkl"
  func::escapeshellarg variable
  EXPECT_EQ "'abc def'\\''ghi\\jkl'" "${variable}"
}
