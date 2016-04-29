test::time() {
  # The current time should be between 2015-01-01 and 2100-01-01.
  EXPECT_LT 1420038000 "$(sub::time)"
  EXPECT_GT 4102412400 "$(sub::time)"

  local result=0
  func::time result
  EXPECT_LT 1420038000 "${result}"
  EXPECT_GT 4102412400 "${result}"
}
