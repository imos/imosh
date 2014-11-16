test::func_hex2bin() {
  local variable=''

  # void func::hex2bin(string* output, string input)
  func::hex2bin variable '686f6765'
  EXPECT_EQ 'hoge' "${variable}"

  # void func::hex2bin(string* variable)
  variable='686f6765'
  func::hex2bin variable
  EXPECT_EQ 'hoge' "${variable}"

  # void stream::hex2bin() < input > output
  EXPECT_EQ 'hoge' "$(echo '686f6765' | stream::hex2bin)"

  # Japanese characters.
  variable='e697a5e69cace8aa9e'
  func::hex2bin variable
  EXPECT_EQ '日本語' "${variable}"

  # Spaces are ignored.
  variable='e6 97 a5 e6 9c ac e8 aa 9e'
  func::hex2bin variable
  EXPECT_EQ '日本語' "${variable}"

  # Spaces including new lines are also ignored.
  variable='e6 97 a5
            e6 9c ac
            e8 aa 9e'
  func::hex2bin variable
  EXPECT_EQ '日本語' "${variable}"
}
