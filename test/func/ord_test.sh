test::func_ord() {
  local variable='A'
  local result=''

  variable='A'
  func::ord result "${variable}"
  EXPECT_EQ 65 "${result}"

  variable='ABC'
  func::ord result "${variable}"
  EXPECT_EQ 65 "${result}"

  variable=$'\n'
  func::ord result "${variable}"
  EXPECT_EQ 10 "${result}"
}
