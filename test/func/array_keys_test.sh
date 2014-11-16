test::func_array_keys() {
  local input=('a' 'b' 'c')
  local variable=()

  func::array_keys variable input
  EXPECT_EQ '0,1,2' "$(sub::implode ',' variable)"
  EXPECT_EQ '0 1 2' "$(sub::array_keys variable)"

  unset input[1]
  func::array_keys variable input
  EXPECT_EQ '0,2' "$(sub::implode ',' variable)"

  input=()
  func::array_keys variable input
  EXPECT_EQ '' "$(sub::implode ',' variable)"
  EXPECT_EQ '' "$(sub::array_keys variable)"
}
