test::ord() {
  EXPECT_EQ 65 "$(ord A)"
  EXPECT_EQ 65 "$(ord ABC)"
  EXPECT_EQ 10 "$(ord $'\n')"
}
