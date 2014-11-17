test::func_boolval() {
  local variable

  variable=12345
  EXPECT_TRUE func::boolval variable
  EXPECT_EQ 1 "${variable}"

  variable=0
  EXPECT_TRUE func::boolval variable
  EXPECT_EQ 0 "${variable}"

  variable=true
  EXPECT_TRUE func::boolval variable
  EXPECT_EQ 1 "${variable}"

  variable=false
  EXPECT_TRUE func::boolval variable
  EXPECT_EQ 0 "${variable}"

  variable='hoge'
  EXPECT_FALSE func::boolval variable
  EXPECT_EQ 0 "${variable}"
}
