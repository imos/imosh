test::sha1() {
  EXPECT_EQ 'da39a3ee5e6b4b0d3255bfef95601890afd80709' "$(sub::sha1 '')"
  EXPECT_EQ '0beec7b5ea3f0fdbc95d0dd47f3c5bc275da8a33' "$(sub::sha1 'foo')"
  EXPECT_EQ 'adc83b19e793491b1c6ea0fd8b46cd9f32e592fc' "$(sub::sha1 $'\n')"
}
