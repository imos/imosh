test::php::preg_match() {
  local match
  php::preg_match '%\d+%' 'abc012def345ghi' match
  EXPECT_EQ '012' "$(func::implode ',' match)"
  php::preg_match '%(\d{4})-(\d{2})-(\d{2})%' 'date: 2014-08-04 12:13:14' match
  EXPECT_EQ '2014-08-04,2014,08,04' "$(func::implode ',' match)"
  if php::preg_match '%\d+%' 'abcdefghi' match; then
    LOG FATAL 'abcdefghi should not match \d+.'
  fi
}
