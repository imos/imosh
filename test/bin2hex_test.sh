test::bin2hex() {
  EXPECT_EQ '686f6765' "$(bin2hex 'hoge')"
  EXPECT_EQ 'e697a5e69cace8aa9e' "$(bin2hex '日本語')"
}
