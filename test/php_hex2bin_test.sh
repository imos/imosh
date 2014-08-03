test::php::hex2bin() {
  EXPECT_EQ 'hoge' "$(php::hex2bin '686f6765')"
  EXPECT_EQ '日本語' "$(php::hex2bin 'e697a5e69cace8aa9e')"
  EXPECT_EQ '日本語' "$(php::hex2bin 'e6 97 a5 e6 9c ac e8 aa 9e')"
  EXPECT_EQ '日本語' "$(php::hex2bin 'e6 97 a5
                                     e6 9c ac
                                     e8 aa 9e')"
}
