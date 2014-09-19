test::func_floatval() {
  local variable

  variable=12345
  func::floatval variable
  EXPECT_EQ 12345 "${variable}"

  variable=-12345678901234567890
  func::floatval variable
  EXPECT_EQ -12345678901234567890 "${variable}"

  variable='   -123.456   '
  func::floatval variable
  EXPECT_EQ -123.456 "${variable}"

  variable='abc'
  if func::floatval variable; then
    LOG FATAL 'abc cannot be cast to a float value.'
  fi
}
