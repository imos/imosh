test::func_addslashes() {
  local variable

  variable="abc\"def\\ghi'jkl"
  func::addslashes variable
  EXPECT_EQ "abc\\\"def\\\\ghi\\'jkl" "${variable}"

  variable='abcdef'
  func::addslashes variable
  EXPECT_EQ 'abcdef' "${variable}"

  variable=''
  func::addslashes variable
  EXPECT_EQ '' "${variable}"

  variable='   '
  func::addslashes variable
  EXPECT_EQ '   ' "${variable}"

  variable=$'abc\tdef\nghi'
  func::addslashes variable
  EXPECT_EQ $'abc\tdef\nghi' "${variable}"
}
