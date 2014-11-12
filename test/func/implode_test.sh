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

  # Command form.
  values=(a b c)
  EXPECT_EQ 'a,b,c' "$(sub::implode ',' values)"

  # Stream form.
  IFS=' \t\n' EXPECT_EQ $'a,b,c\nd,e\nf' \
                        "$(stream::implode ',' <<<$'a b c\nd\te\nf')"
}
