test::func_strval() {
  local variable

  variable=12345
  func::strval variable
  EXPECT_EQ 12345 "${variable}"

  variable=-12345678901234567890
  func::strval variable
  EXPECT_EQ -12345678901234567890 "${variable}"

  variable='   -123.456   '
  func::strval variable
  EXPECT_EQ '   -123.456   ' "${variable}"

  variable='abc'
  func::strval variable
  EXPECT_EQ 'abc' "${variable}"
}
