test::in_array() {
  local array1=()
  local array2=('')
  local array3=('foo')
  local string1=''
  local string2='foo'

  EXPECT_TRUE sub::is_array array1
  EXPECT_TRUE sub::is_array array2
  EXPECT_TRUE sub::is_array array3

  EXPECT_FALSE sub::is_array array3[0]
  EXPECT_FALSE sub::is_array string1
  EXPECT_FALSE sub::is_array string2
}
