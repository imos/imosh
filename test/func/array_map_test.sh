run_test_case() {
  local variable=()
  
  variable=("${INPUT[@]}")
  func::array_map variable "$@"
  EXPECT_EQ "${EXPECTED}" "$(func::implode $'\n' variable)"

  variable=("${INPUT[@]}")
  local actual="$(
      func::implode $'\n' variable |
      stream::array_map "$@")"
  EXPECT_EQ "${EXPECTED}" "${actual}"
}

test::func_array_map() {
  local variable=()

  # Test for array functions (e.g. func::sort).
  variable=('def,abc,ghi' '1,3,2,5,4')
  IFS=',' func::array_map variable ARRAY func::sort
  EXPECT_EQ $'abc,def,ghi\n1,2,3,4,5' "$(func::implode $'\n' variable)"

  # Test for regular functions (e.g. func::bin2hex).
  variable=('a,b,c' '1 2 3')
  func::array_map variable FUNCTION func::bin2hex
  EXPECT_EQ $'612c622c63\n3120322033' "$(func::implode $'\n' variable)"

  # Test for inplace functions (e.g. func::str_replace).
  variable=('abcbd' 'bcdbcb')
  func::array_map variable INPLACE func::str_replace 'bc' 'BC'
  EXPECT_EQ $'aBCbd\nBCdBCb' "$(func::implode $'\n' variable)"

  # Test for command functions (e.g. sub::strtoupper).
  variable=('abcbd' 'bcdbcb')
  func::array_map variable COMMAND sub::strtoupper
  EXPECT_EQ $'ABCBD\nBCDBCB' "$(func::implode $'' variable)"
}

test::stream_array_map() {
  local actual=''

  # Test for array functions (e.g. func::sort).
  actual="$(
      func::print $'def,abc,ghi\n1,3,2,5,4' |
      IFS=',' stream::array_map ARRAY func::sort)"
  EXPECT_EQ $'abc,def,ghi\n1,2,3,4,5' "${actual}"

  # Test for regular functions (e.g. func::bin2hex).
  actual="$(
      func::print $'a,b,c\n1 2 3' |
      stream::array_map FUNCTION func::bin2hex)"
  EXPECT_EQ $'612c622c63\n3120322033' "${actual}"

  # Test for inplace functions (e.g. func::str_replace).
  actual="$(
      func::print $'abcbd\nbcdbcb' |
      stream::array_map INPLACE func::str_replace 'bc' 'BC')"
  EXPECT_EQ $'aBCbd\nBCdBCb' "${actual}"

  # Test for command functions (e.g. sub::strtoupper).
  actual="$(
      func::print $'abcbd\nbcdbcb' |
      stream::array_map COMMAND sub::strtoupper)"
  EXPECT_EQ $'ABCBD\nBCDBCB' "${actual}"
}
