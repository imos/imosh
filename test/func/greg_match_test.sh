test::func_greg_match() {
  EXPECT_TRUE func::greg_match '*def*' 'abcdefghi'
  EXPECT_FALSE func::greg_match '*xyz*' 'abcdefghi'
  EXPECT_TRUE func::greg_match '*([a-z])' 'abcdefghi'
  EXPECT_FALSE func::greg_match '*([a-z])' 'abc123ghi'
}
