EXPECT_TRUE() {
  if ! "$@"; then
    echo '  Actual: false' >&2
    echo 'Expected: true' >&2
    IMOSH_TEST_IS_FAILED=1
    return 1
  fi
}

EXPECT_FALSE() {
  if "$@"; then
    echo '  Actual: true' >&2
    echo 'Expected: false' >&2
    IMOSH_TEST_IS_FAILED=1
    return 1
  fi
}

ASSERT_TRUE() {
  ASSERT EXPECT_TRUE "$@"
}

ASSERT_FALSE() {
  ASSERT EXPECT_FALSE "$@"
}
