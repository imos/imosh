test::func_println() {
  EXPECT_EQ '686f67650a' "$(func::println 'hoge' | func::bin2hex)"
  EXPECT_EQ '686f67650a0a' "$(func::println $'hoge\n' | func::bin2hex)"
  EXPECT_EQ '010203040a' "$(func::println $'\x01\x02\x03\x04' | func::bin2hex)"
}
