test::func_let() {
  local destination

  func::let destination 'test'
  EXPECT_EQ 'test' "${destination}"

  func::let destination $'abc\x00\x01\x02\x03\x04\x05\x06\x07\x08xyz'
  EXPECT_EQ $'abc\x00\x01\x02\x03\x04\x05\x06\x07\x08xyz' "${destination}"
}
