test::func_trim() {
  local variable=''

  variable='  abc def  '
  func::trim variable
  EXPECT_EQ 'abc def' "${variable}"

  variable=$'\t\n\r \t\n\rabc def  '
  func::trim variable
  EXPECT_EQ 'abc def' "${variable}"

  variable='abc def'
  func::trim variable
  EXPECT_EQ 'abc def' "${variable}"

  variable=''
  func::trim variable
  EXPECT_EQ '' "${variable}"

  variable=' '
  func::trim variable
  EXPECT_EQ '' "${variable}"

  variable='     '
  func::trim variable
  EXPECT_EQ '' "${variable}"

  variable=$'\t\n\r \t\n\r'
  func::trim variable
  EXPECT_EQ '' "${variable}"
}
