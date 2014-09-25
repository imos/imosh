run_testcase() {
  local expected="$1"
  local input="$2"

  # 1. Function form.
  local variable="${input}"
  func::strtolower variable
  EXPECT_EQ "${expected}" "${variable}"

  # 2. Stream form.
  EXPECT_EQ "${expected}" "$(func::print "${input}" | func::strtolower)"
}

test::func_strtolower() {
  run_testcase 'abc def ghi 123 ひらがな 漢字 カタカナ' \
               'ABC def Ghi 123 ひらがな 漢字 カタカナ'

  run_testcase \
      'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz0123456789' \
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'

  # Symbols.  Symbols do not change.
  run_testcase $' !"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~' \
               $' !"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
  run_testcase $'\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0e\x0f\x10' \
               $'\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0e\x0f\x10'
  run_testcase $'\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1e\x1f\x7f' \
               $'\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1e\x1f\x7f'
}
