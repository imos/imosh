test::array_is_empty() {
  local array1=()
  local array2=('')
  local array3=('foo')

  EXPECT_TRUE sub::array_is_empty array1
  EXPECT_FALSE sub::array_is_empty array2
  EXPECT_FALSE sub::array_is_empty array3
}
