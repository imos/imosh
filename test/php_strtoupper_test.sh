test::strtoupper() {
  EXPECT_EQ 'ABC DEF GHI 123 ひらがな 漢字 カタカナ' \
            "$(php::strtoupper 'ABC def Ghi 123 ひらがな 漢字 カタカナ')"
}
