test::md5_file() {
  touch "${TMPDIR}/md5_file"
  EXPECT_EQ 'd41d8cd98f00b204e9800998ecf8427e' \
            "$(sub::md5_file "${TMPDIR}/md5_file")"

  echo -n 'foo' >"${TMPDIR}/md5_file"
  EXPECT_EQ 'acbd18db4cc2f85cedef654fccc4a4d8' \
            "$(sub::md5_file "${TMPDIR}/md5_file")"

  local result=''
  func::md5_file result "${TMPDIR}/md5_file"
  EXPECT_EQ 'acbd18db4cc2f85cedef654fccc4a4d8' "${result}"
}
