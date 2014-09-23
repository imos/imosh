test::func_strtolower() {
  local variable=''

  variable='ABC def Ghi 123 ひらがな 漢字 カタカナ'
  func::strtolower variable
  EXPECT_EQ 'abc def ghi 123 ひらがな 漢字 カタカナ' "${variable}"

  variable='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  func::strtolower variable
  EXPECT_EQ 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz0123456789' \
            "${variable}"

  variable=$' !"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  func::strtolower variable
  EXPECT_EQ $' !"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~' "${variable}"

  variable=$'\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0e\x0f\x10'
  func::strtolower variable
  EXPECT_EQ $'\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0e\x0f\x10' \
            "${variable}"

  variable=$'\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1e\x1f\x7f'
  func::strtolower variable
  EXPECT_EQ $'\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1e\x1f\x7f' \
            "${variable}"
}
