test::in_array() {
  local array1=()
  local array2=('')
  local array3=('foo')
  local array4=('foo' 'bar')

  EXPECT_FALSE sub::in_array '' array1
  EXPECT_TRUE sub::in_array '' array2
  EXPECT_FALSE sub::in_array '' array3
  EXPECT_FALSE sub::in_array '' array4

  EXPECT_FALSE sub::in_array 'foo' array1
  EXPECT_FALSE sub::in_array 'foo' array2
  EXPECT_TRUE sub::in_array 'foo' array3
  EXPECT_TRUE sub::in_array 'foo' array4

  EXPECT_FALSE sub::in_array 'bar' array1
  EXPECT_FALSE sub::in_array 'bar' array2
  EXPECT_FALSE sub::in_array 'bar' array3
  EXPECT_TRUE sub::in_array 'bar' array4

  EXPECT_FALSE sub::in_array 'baz' array1
  EXPECT_FALSE sub::in_array 'baz' array2
  EXPECT_FALSE sub::in_array 'baz' array3
  EXPECT_FALSE sub::in_array 'baz' array4
}
