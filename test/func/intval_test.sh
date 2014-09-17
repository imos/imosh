test::func_intval() {
  local variable

  variable=12345
  func::intval variable
  EXPECT_EQ 12345 "${variable}"

  variable=-12345678901234567890
  func::intval variable
  EXPECT_EQ -12345678901234567890 "${variable}"

  variable='   -123.456   '
  func::intval variable
  EXPECT_EQ -123 "${variable}"

  variable='abc'
  if func::intval variable; then
    LOG FATAL 'abc cannot be cast to an integer.'
  fi
}
