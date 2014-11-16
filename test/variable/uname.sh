test::uname() {
  EXPECT_TRUE sub::isset UNAME
  EXPECT_NE '' "${UNAME}"
}
