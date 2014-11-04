test::func_println() {
  EXPECT_EQ '686f67650a' "$(sub::println 'hoge' | func::bin2hex)"
  EXPECT_EQ '686f67650a0a' "$(sub::println $'hoge\n' | func::bin2hex)"
  EXPECT_EQ '010203040a' "$(sub::println $'\x01\x02\x03\x04' | func::bin2hex)"
}
