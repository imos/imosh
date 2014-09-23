test::uname() {
  EXPECT_TRUE func::isset UNAME
  EXPECT_NE '' "${UNAME}"
}
