test::EXPECT_TRUE() {
  EXPECT_TRUE true 2>/dev/null
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -eq 0 ]
  EXPECT_TRUE false 2>/dev/null
  ASSERT_TRUE [ "${IMOSH_TEST_IS_FAILED}" -ne 0 ]
  IMOSH_TEST_IS_FAILED=0
}
