test::func_bin2hex() {
  EXPECT_EQ '686f6765' "$(print 'hoge' | php::bin2hex)"
  EXPECT_EQ 'e697a5e69cace8aa9e' "$(print '日本語' | func::bin2hex)"
}
