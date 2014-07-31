test::shell_escape() {
  EXPECT_EQ "'foo'" "$(imosh::shell_escape foo)"
  EXPECT_EQ "'foo'\"'\"'bar'" "$(imosh::shell_escape "foo'bar")"
}
