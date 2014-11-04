test::func_bin2hex() {
  EXPECT_EQ '686f6765' "$(sub::print 'hoge' | func::bin2hex)"
  EXPECT_EQ 'e697a5e69cace8aa9e' "$(sub::print '日本語' | func::bin2hex)"

  local variable
  func::bin2hex variable 'hoge'
  EXPECT_EQ '686f6765' "${variable}"
}
