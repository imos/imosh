test::sub_greg_match() {
  EXPECT_TRUE sub::greg_match '*def*' 'abcdefghi'
  EXPECT_FALSE sub::greg_match '*xyz*' 'abcdefghi'
  EXPECT_TRUE sub::greg_match '*([a-z])' 'abcdefghi'
  EXPECT_FALSE sub::greg_match '*([a-z])' 'abc123ghi'
}
