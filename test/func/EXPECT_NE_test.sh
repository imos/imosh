test::EXPECT_NE() {
  EXPECT_NE 'abc' 'def' 2>'/dev/null' 105>'/dev/null'
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -eq 0 ]
  EXPECT_NE 'abc' 'abc' 2>'/dev/null' 105>'/dev/null'
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -ne 0 ]
  IMOSH_TEST_IS_FAILED=0
}
