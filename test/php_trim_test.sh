test::php::trim() {
  EXPECT_EQ 'abc def' "$(php::trim '  abc def  ')"
  EXPECT_EQ 'abc def' "$(php::trim $'\t\n\r \t\n\rabc def\t\n\r \t\n\r')"
  EXPECT_EQ 'abc def' "$(php::trim $'abc def')"
  EXPECT_EQ '' "$(php::trim $'')"
  EXPECT_EQ '' "$(php::trim $' ')"
  EXPECT_EQ '' "$(php::trim $'     ')"
  EXPECT_EQ '' "$(php::trim $'\t\n\r \t\n\r')"
}
