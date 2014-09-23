test::func_implode() {
  local values=()

  values=(a b c)
  func::implode variable ' ' values
  EXPECT_EQ 'a b c' "${variable}"

  func::implode variable 'xxx' values
  EXPECT_EQ 'axxxbxxxc' "${variable}"

  values=(';' ' ' $'\n' '\' '')
  func::implode variable ' ' values
  EXPECT_EQ $';   \n \\ ' "${variable}"

  func::implode variable 'xxx' values
  EXPECT_EQ $';xxx xxx\nxxx\\xxx' "${variable}"
}