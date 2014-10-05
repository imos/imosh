test::func_greg_split() {
  local variable=()

  func::greg_split variable $'[ \t\n]' $'a b\tc'
  EXPECT_EQ 3 "${#variable[*]}"
  func::implode variable ',' variable
  EXPECT_EQ 'a,b,c' "${variable}"
}
