test::parse_arguments() {
  set -- --foo arg1 --bar=$'abc\'def -- ghi;jkl \n mno"=pqr \t stu' arg2
  eval "${IMOSH_PARSE_ARGUMENTS}"
  EXPECT_EQ 2 "${#IMOSH_ARGV[@]}"
  EXPECT_EQ arg1 "${IMOSH_ARGV[0]}"
  EXPECT_EQ arg2 "${IMOSH_ARGV[1]}"
  EXPECT_EQ 1 "${FLAGS_foo}"
  EXPECT_EQ $'abc\'def -- ghi;jkl \n mno"=pqr \t stu' "${FLAGS_bar}"
}
