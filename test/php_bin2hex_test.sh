test::php::bin2hex() {
  EXPECT_EQ '686f6765' "$(php::bin2hex 'hoge')"
  EXPECT_EQ 'e697a5e69cace8aa9e' "$(php::bin2hex '日本語')"
}
