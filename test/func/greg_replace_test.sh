test::func_greg_replace() {
  local variable

  variable='abc def ghi'
  func::greg_replace variable '[[:space:]]' 'x'
  EXPECT_EQ 'abcxdefxghi' "${variable}"

  variable='abc def  ghi'
  func::greg_replace variable '+( )' 'xyz'
  EXPECT_EQ 'abcxyzdefxyzghi' "${variable}"

  variable='abcdefghi'
  func::greg_replace variable '[beh]' 'x'
  EXPECT_EQ 'axcdxfgxi' "${variable}"

  variable=$'abc\tdef\nghi'
  func::greg_replace variable '[[:cntrl:][:print:]]' 'x'
  EXPECT_EQ 'xxxxxxxxxxx' "${variable}"
}
