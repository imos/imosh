run_test_case() {
  local type="$1"
  local variable=()
  
  variable=("${INPUT[@]}")
  func::array_map variable "$@"
  if [ "${type}" = 'COMMAND' ]; then
    EXPECT_EQ "${EXPECTED}" "$(func::implode $'' variable)"
  else
    EXPECT_EQ "${EXPECTED}" "$(func::implode $'\n' variable)"
  fi

  variable=("${INPUT[@]}")
  local actual="$(
      func::implode $'\n' variable |
      stream::array_map "$@")"
  EXPECT_EQ "${EXPECTED}" "${actual}"
}

test::func_array_map() {
  local variable=()

  # Test for array functions (e.g. func::sort).
  INPUT=('def,abc,ghi' '1,3,2,5,4')
  EXPECTED=$'abc,def,ghi\n1,2,3,4,5'
  IFS=',' run_test_case ARRAY func::sort

  # Test for regular functions (e.g. func::bin2hex).
  INPUT=('a,b,c' '1 2 3')
  EXPECTED=$'612c622c63\n3120322033'
  run_test_case FUNCTION func::bin2hex

  # Test for inplace functions (e.g. func::str_replace).
  INPUT=('abcbd' 'bcdbcb')
  EXPECTED=$'aBCbd\nBCdBCb'
  run_test_case INPLACE func::str_replace 'bc' 'BC'

  # Test for command functions (e.g. sub::strtoupper).
  INPUT=('abcbd' 'bcdbcb')
  EXPECTED=$'ABCBD\nBCDBCB'
  run_test_case COMMAND sub::strtoupper
}
