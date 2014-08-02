test::strtoupper() {
  EXPECT_EQ 'abc def ghi 123 ひらがな 漢字 カタカナ' \
            "$(php::strtolower 'ABC def Ghi 123 ひらがな 漢字 カタカナ')"
}
