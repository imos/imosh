test::func_ltrim() {
  local variable=''

  variable='  abc def  '
  func::ltrim variable
  EXPECT_EQ 'abc def  ' "${variable}"

  variable=$'\t\n\r \t\n\rabc def  '
  func::ltrim variable
  EXPECT_EQ 'abc def  ' "${variable}"

  variable='abc def'
  func::ltrim variable
  EXPECT_EQ 'abc def' "${variable}"

  variable=''
  func::ltrim variable
  EXPECT_EQ '' "${variable}"

  variable=' '
  func::ltrim variable
  EXPECT_EQ '' "${variable}"

  variable='     '
  func::ltrim variable
  EXPECT_EQ '' "${variable}"

  variable=$'\t\n\r \t\n\r'
  func::ltrim variable
  EXPECT_EQ '' "${variable}"
}
