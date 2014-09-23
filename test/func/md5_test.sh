test::func_md5() {
  EXPECT_EQ 'd41d8cd98f00b204e9800998ecf8427e' "$(func::md5 '')"
  EXPECT_EQ 'acbd18db4cc2f85cedef654fccc4a4d8' "$(func::md5 'foo')"
  EXPECT_EQ '68b329da9893e34099c7d8ad5cb9c940' "$(func::md5 $'\n')"
}
