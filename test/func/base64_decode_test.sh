run() {
  local expected="${1}"
  local input="${2}"

  local result=''
  func::base64_decode result "${input}"
  EXPECT_EQ "${expected}" "${result}"

  local result=''
  local tmpfile=''
  func::tmpfile tmpfile
  sub::base64_decode "${input}" >"${tmpfile}"
  func::file_get_contents result "${tmpfile}"
  EXPECT_EQ "${expected}" "${result}"

  local result=''
  func::file_get_contents result "${tmpfile}"
  sub::print "${input}" | stream::base64_decode >"${tmpfile}"
  func::file_get_contents result "${tmpfile}"
  EXPECT_EQ "${expected}" "${result}"
}

test::base64_decode() {
  run '' ''
  run 'f' 'Zg=='
  run 'f' 'Zg'
  run 'foo' 'Zm9v'
  run 'hogehoge' 'aG9nZWhvZ2U='
  run 'hogehoge' 'aG9nZWhvZ2U'
}
