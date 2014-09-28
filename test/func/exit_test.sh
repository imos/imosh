test::func_exit() {
  EXPECT_EQ 123 "$(
      "${SHELL}" "test/script/exit.sh" \
          --status=123 --depth=2 --exit_depth=1 2>/dev/null;
      echo "$?";
      sleep 5)"
}
