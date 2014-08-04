test::php::array_map() {
  php::start

  local values=('abc' 'DEF' 'Ghi')
  php::array_map php::strtolower values
  EXPECT_EQ 'abc;def;ghi' "$(php::implode ';' values)"
  for i in {1..20}; do
    values+=("${i}")
  done
  php::array_map php::md5 values
}
