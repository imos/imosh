test::func_cast() {
  local variable

  variable=' 12345 '
  EXPECT_TRUE func::cast variable string
  EXPECT_EQ ' 12345 ' "${variable}"
  EXPECT_TRUE func::cast variable int
  EXPECT_EQ 12345 "${variable}"
  EXPECT_TRUE func::cast variable bool
  EXPECT_EQ 1 "${variable}"
}
