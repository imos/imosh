test::EXPECT_FALSE() {
  EXPECT_FALSE false 2>'/dev/null' 105>'/dev/null'
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -eq 0 ]
  EXPECT_FALSE true 2>'/dev/null' 105>'/dev/null'
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -ne 0 ]
  IMOSH_TEST_IS_FAILED=0
}
