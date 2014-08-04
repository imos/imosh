test::php::array_map() {
  local values=('abc' 'DEF' 'Ghi')
  php::array_map php::strtolower values
  EXPECT_EQ 'abc;def;ghi' "$(php::implode ';' values)"
}
