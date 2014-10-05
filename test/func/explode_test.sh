test::func_explode() {
  local values=()
  local actual=''

  func::explode values ' ' 'abc def ghi'
  func::implode actual ',' values
  EXPECT_EQ 'abc,def,ghi' "${actual}"

  func::explode values 'xyz' $'ab\ncxyzde\tfxyzxyzgh i'
  func::implode actual ',' values
  EXPECT_EQ $'ab\nc,de\tf,,gh i' "${actual}"

  func::explode values ' ' ''
  func::implode actual ',' values
  EXPECT_EQ '' "${actual}"
  EXPECT_EQ 1 "${#values[*]}"

  func::explode values ' ' ' '
  func::implode actual ',' values
  EXPECT_EQ ',' "${actual}"
  EXPECT_EQ 2 "${#values[*]}"

  func::explode values ';' '\\;*;?;'
  func::implode actual ',' values
  EXPECT_EQ '\\,*,?,' "${actual}"
}
