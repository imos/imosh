test::func_str_replace() {
  local variable

  variable='abc def ghi'
  func::str_replace variable ' ' 'x'
  EXPECT_EQ 'abcxdefxghi' "${variable}"

  variable='abc def ghi'
  func::str_replace variable ' ' 'xyz'
  EXPECT_EQ 'abcxyzdefxyzghi' "${variable}"

  variable='abcdefghi'
  func::str_replace variable 'def' 'x'
  EXPECT_EQ 'abcxghi' "${variable}"

  variable='aaaaaaaa'
  func::str_replace variable 'aaa' 'bbb'
  EXPECT_EQ 'bbbbbbaa' "${variable}"

  variable='abcdefghi'
  func::str_replace variable 'x' 'y'
  EXPECT_EQ 'abcdefghi' "${variable}"

  variable=$'abc\ndef'
  func::str_replace variable $'\n' ' '
  EXPECT_EQ 'abc def' "${variable}"

  variable='abc/def/ghi'
  func::str_replace variable '/' '//'
  EXPECT_EQ 'abc//def//ghi' "${variable}"
}
