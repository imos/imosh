test::ord() {
  EXPECT_EQ 65 "$(php::ord A)"
  EXPECT_EQ 65 "$(php::ord ABC)"
  EXPECT_EQ 10 "$(php::ord $'\n')"
}
