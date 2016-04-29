test::function_exists() {
  EXPECT_TRUE sub::function_exists test::function_exists
  EXPECT_TRUE sub::function_exists cd
  EXPECT_FALSE sub::function_exists no_such_function
}
