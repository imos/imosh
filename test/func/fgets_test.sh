test::func_fgets() {
  local variable=''

  sub::print $'abc\ndef\n' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ $'abc\n' "${variable}"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ $'def\n' "${variable}"
  EXPECT_FALSE func::fgets variable
  EXPECT_EQ '' "${variable}"

  sub::print $'abc\ndef' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ $'abc\n' "${variable}"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ 'def' "${variable}"
  EXPECT_FALSE func::fgets variable
  EXPECT_EQ '' "${variable}"

  sub::print $'abc\r\ndef\r\n' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ $'abc\r\n' "${variable}"
  EXPECT_TRUE func::fgets variable
  EXPECT_EQ $'def\r\n' "${variable}"
  EXPECT_FALSE func::fgets variable
  EXPECT_EQ '' "${variable}"
}
