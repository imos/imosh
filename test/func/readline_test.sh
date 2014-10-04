test::func_readline() {
  local variable=''
  local LINE='' NEWLINE=''

  func::print $'abc\ndef\n' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'abc' "${LINE}"
  EXPECT_EQ $'\n' "${NEWLINE}"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'def' "${LINE}"
  EXPECT_EQ $'\n' "${NEWLINE}"
  EXPECT_FALSE func::readline
  EXPECT_EQ '' "${LINE}"
  EXPECT_EQ '' "${NEWLINE}"

  func::print $'abc\n\ndef' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'abc' "${LINE}"
  EXPECT_EQ $'\n' "${NEWLINE}"
  EXPECT_TRUE func::readline
  EXPECT_EQ '' "${LINE}"
  EXPECT_EQ $'\n' "${NEWLINE}"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'def' "${LINE}"
  EXPECT_EQ '' "${NEWLINE}"
  EXPECT_FALSE func::readline
  EXPECT_EQ '' "${LINE}"
  EXPECT_EQ '' "${NEWLINE}"

  func::print $'abc\r\n\r\ndef\r\n' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'abc' "${LINE}"
  EXPECT_EQ $'\r\n' "${NEWLINE}"
  EXPECT_TRUE func::readline
  EXPECT_EQ '' "${LINE}"
  EXPECT_EQ $'\r\n' "${NEWLINE}"
  EXPECT_TRUE func::readline
  EXPECT_EQ 'def' "${LINE}"
  EXPECT_EQ $'\r\n' "${NEWLINE}"
  EXPECT_FALSE func::readline
  EXPECT_EQ '' "${LINE}"
  EXPECT_EQ '' "${NEWLINE}"
}
