test::func_rtrim() {
  local variable=''

  variable='  abc def  '
  func::rtrim variable
  EXPECT_EQ '  abc def' "${variable}"

  variable=$'  abc def\t\n\r \t\n\r'
  func::rtrim variable
  EXPECT_EQ '  abc def' "${variable}"

  variable='abc def'
  func::rtrim variable
  EXPECT_EQ 'abc def' "${variable}"

  variable=''
  func::rtrim variable
  EXPECT_EQ '' "${variable}"

  variable=' '
  func::rtrim variable
  EXPECT_EQ '' "${variable}"

  variable='     '
  func::rtrim variable
  EXPECT_EQ '' "${variable}"

  variable=$'\t\n\r \t\n\r'
  func::rtrim variable
  EXPECT_EQ '' "${variable}"
}
