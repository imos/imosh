test::func_file_get_contents() {
  local variable=''

  sub::print 'abc' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ 'abc' "${variable}"

  sub::print $'abc def\nghi jkl\n' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ $'abc def\nghi jkl\n' "${variable}"

  sub::print '' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ '' "${variable}"
}

test::sub_file_get_contents() {
  sub::print 'abc' > "${TMPDIR}/test"
  EXPECT_EQ 'abc' "$(sub::file_get_contents "${TMPDIR}/test")"
}

test::stream_file_get_contents() {
  sub::print 'abc' > "${TMPDIR}/test1"
  sub::print 'def' > "${TMPDIR}/test2"
  EXPECT_EQ 'abcdef' "$(
      { echo "${TMPDIR}/test1"; echo "${TMPDIR}/test2"; } | \
          stream::file_get_contents)"
}
