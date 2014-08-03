test::php::explode() {
  local values=()
  php::explode values ' ' 'abc def ghi'
  EXPECT_EQ 'abc,def,ghi' "$(php::implode ',' values)"
  local values=()
  php::explode values 'xyz' $'ab\ncxyzde\tfxyzgh i'
  EXPECT_EQ $'ab\nc,de\tf,gh i' "$(php::implode ',' values)"
}
