test::php::rtrim() {
  EXPECT_EQ '  abc def' "$(php::rtrim '  abc def  ')"
  EXPECT_EQ '  abc def' "$(php::rtrim $'  abc def\t\n\r \t\n\r')"
  EXPECT_EQ 'abc def' "$(php::rtrim $'abc def')"
  EXPECT_EQ '' "$(php::rtrim $'')"
  EXPECT_EQ '' "$(php::rtrim $' ')"
  EXPECT_EQ '' "$(php::rtrim $'     ')"
  EXPECT_EQ '' "$(php::rtrim $'\t\n\r \t\n\r')"
}
