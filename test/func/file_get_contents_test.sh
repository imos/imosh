test::func_file_get_contents() {
  local variable=''

  func::print 'abc' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ 'abc' "${variable}"

  func::print $'abc def\nghi jkl\n' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ $'abc def\nghi jkl\n' "${variable}"

  func::print '' > "${TMPDIR}/test"
  func::file_get_contents variable "${TMPDIR}/test"
  EXPECT_EQ '' "${variable}"

  func::print 'abc' > "${TMPDIR}/test"
  EXPECT_EQ 'abc' "$(stream::file_get_contents "${TMPDIR}/test")"

  func::print 'abc' > "${TMPDIR}/test1"
  func::print 'def' > "${TMPDIR}/test2"
  EXPECT_EQ 'abcdef' "$(
      { echo "${TMPDIR}/test1"; echo "${TMPDIR}/test2"; } | \
          stream::file_get_contents)"
}
