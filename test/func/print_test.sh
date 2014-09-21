test::func_print() {
  EXPECT_EQ '686f6765' "$(func::print 'hoge' | php::bin2hex)"
  EXPECT_EQ '686f67650a' "$(func::print $'hoge\n' | php::bin2hex)"
  EXPECT_EQ '01020304' "$(func::print $'\x01\x02\x03\x04' | php::bin2hex)"
}
