test::func_readarray() {
  local variable=''
  local LINE=() NEWLINE=''

  sub::print $'abc\tdef\tghi\n' > "${TMPDIR}/test"
  exec < "${TMPDIR}/test"
  IFS=$' \t\n' EXPECT_TRUE func::readarray
  func::implode variable ',' LINE
  LOG INFO "LINE: ${LINE[*]}"
  EXPECT_EQ 'abc,def,ghi' "${variable}"
  EXPECT_EQ $'\n' "${NEWLINE}"
  EXPECT_FALSE func::readarray
  EXPECT_EQ 0 "${#LINE[*]}"
  EXPECT_EQ '' "${NEWLINE}"
}
