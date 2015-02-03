run() {
  local expected="${1}"
  local input="${2}"

  local result=''
  func::base64_encode result "${input}"
  EXPECT_EQ "${expected}" "${result}"

  local result=''
  local tmpfile=''
  func::tmpfile tmpfile
  sub::base64_encode "${input}" >"${tmpfile}"
  func::file_get_contents result "${tmpfile}"
  EXPECT_EQ "${expected}"$'\n' "${result}"

  local result=''
  func::file_get_contents result "${tmpfile}"
  sub::print "${input}" | stream::base64_encode >"${tmpfile}"
  func::file_get_contents result "${tmpfile}"
  EXPECT_EQ "${expected}" "${result}"
}

test::base64_encode() {
  run '' ''
  run 'Zg==' 'f'
  run 'Zm9v' 'foo'
  run 'aG9nZWhvZ2U=' 'hogehoge'
}
