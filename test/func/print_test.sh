test::func_print() {
  EXPECT_EQ '686f6765' "$(sub::print 'hoge' | func::bin2hex)"
  EXPECT_EQ '686f67650a' "$(sub::print $'hoge\n' | func::bin2hex)"
  EXPECT_EQ '01020304' "$(sub::print $'\x01\x02\x03\x04' | func::bin2hex)"
}
