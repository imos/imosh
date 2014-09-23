test::func_strcpy() {
  local source destination

  source='test'
  func::strcpy destination source
  EXPECT_EQ 'test' "${destination}"

  source=$'abc\x00\x01\x02\x03\x04\x05\x06\x07\x08xyz'
  func::strcpy destination source
  EXPECT_EQ $'abc\x00\x01\x02\x03\x04\x05\x06\x07\x08xyz' "${destination}"
}
