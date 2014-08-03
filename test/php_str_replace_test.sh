test::php::str_replace() {
  EXPECT_EQ 'abcxdefxghi' "$(php::str_replace ' ' 'x' 'abc def ghi')"
  EXPECT_EQ 'abcxyzdefxyzghi' "$(php::str_replace ' ' 'xyz' 'abc def ghi')"
  EXPECT_EQ 'abcxghi' "$(php::str_replace 'def' 'x' 'abcdefghi')"
  EXPECT_EQ 'abcxyzghi' "$(php::str_replace 'def' 'xyz' 'abcdefghi')"
  EXPECT_EQ 'bbbbbbaa' "$(php::str_replace 'aaa' 'bbb' 'aaaaaaaa')"
  EXPECT_EQ 'abcdefghi' "$(php::str_replace 'x' 'y' 'abcdefghi')"
  EXPECT_EQ 'abc def' "$(php::str_replace $'\n' ' ' $'abc\ndef')"
  EXPECT_EQ 'abc//def//ghi' "$(php::str_replace '/' '//' 'abc/def/ghi')"
}
