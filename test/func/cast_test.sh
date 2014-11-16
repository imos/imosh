test::func_cast() {
  local variable

  variable=' 12345 '
  EXPECT_TRUE func::cast variable STRING
  EXPECT_EQ ' 12345 ' "${variable}"
  EXPECT_TRUE func::cast variable INT
  EXPECT_EQ 12345 "${variable}"
  EXPECT_TRUE func::cast variable BOOL
  EXPECT_EQ 1 "${variable}"
}
