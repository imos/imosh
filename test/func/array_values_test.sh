test::array_values() {
  local array1=()
  local array2=('')
  local array3=('foo')
  local array4=('foo' 'bar')

  EXPECT_EQ '' "$(IFS=, sub::array_values array1)"
  EXPECT_EQ '' "$(IFS=, sub::array_values array2)"
  EXPECT_EQ 'foo' "$(IFS=, sub::array_values array3)"
  EXPECT_EQ 'foo,bar' "$(IFS=, sub::array_values array4)"

  func::array_values result array1
  EXPECT_EQ '0' "${#result[*]}"
  func::array_values result array2
  EXPECT_EQ '1' "${#result[*]}"
  EXPECT_EQ '' "${result[0]}"
  func::array_values result array3
  EXPECT_EQ '1' "${#result[*]}"
  EXPECT_EQ 'foo' "${result[0]}"
  func::array_values result array4
  EXPECT_EQ '2' "${#result[*]}"
  EXPECT_EQ 'foo' "${result[0]}"
  EXPECT_EQ 'bar' "${result[1]}"
}
