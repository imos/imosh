test::php::ltrim() {
  EXPECT_EQ 'abc def  ' "$(php::ltrim '  abc def  '; echo)"
  EXPECT_EQ 'abc def  ' "$(php::ltrim $'\t\n\r \t\n\rabc def  '; echo)"
  EXPECT_EQ 'abc def' "$(php::ltrim $'abc def')"
  EXPECT_EQ '' "$(php::ltrim $'')"
  EXPECT_EQ '' "$(php::ltrim $' ')"
  EXPECT_EQ '' "$(php::ltrim $'     ')"
  EXPECT_EQ '' "$(php::ltrim $'\t\n\r \t\n\r')"
}
