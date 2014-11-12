test::func_print() {
  EXPECT_EQ '686f6765' "$(sub::print 'hoge' | stream::bin2hex)"
  EXPECT_EQ '686f67650a' "$(sub::print $'hoge\n' | stream::bin2hex)"
  EXPECT_EQ '01020304' "$(sub::print $'\x01\x02\x03\x04' | stream::bin2hex)"
}
