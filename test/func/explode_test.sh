test::func_explode() {
  local values=()
  local actual=''

  func::explode values ' ' 'abc def ghi'
  func::implode actual ',' values
  EXPECT_EQ 'abc,def,ghi' "${actual}"

  func::explode values 'xyz' $'ab\ncxyzde\tfxyzgh i'
  func::implode actual ',' values
  EXPECT_EQ $'ab\nc,de\tf,gh i' "${actual}"

  func::explode values ';' '\\;*;?;'
  func::implode actual ',' values
  EXPECT_EQ '\\,*,?,' "${actual}"
}
