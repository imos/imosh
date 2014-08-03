test::php::implode() {
  local values=(a b c)
  EXPECT_EQ 'a b c' "$(php::implode ' ' values)"
  EXPECT_EQ 'axxxbxxxc' "$(php::implode 'xxx' values)"
  local values=(';' ' ' $'\n' '')
  EXPECT_EQ $';   \n ' "$(php::implode ' ' values)"
  EXPECT_EQ $';xxx xxx\nxxx' "$(php::implode 'xxx' values)"
}
