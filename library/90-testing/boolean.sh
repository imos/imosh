EXPECT_TRUE() {
  if ! "$@"; then
    echo '  Actual: false' >&2
    echo 'Expected: true' >&2
    FAILURE
    return 1
  fi
  IFS=' ' eval 'LOG INFO "EXPECT_TRUE passes: $*"'
}

EXPECT_FALSE() {
  if "$@"; then
    echo '  Actual: true' >&2
    echo 'Expected: false' >&2
    FAILURE
    return 1
  fi
  IFS=' ' eval 'LOG INFO "EXPECT_FALSE passes: $*"'
}

ASSERT_TRUE() {
  ASSERT EXPECT_TRUE "$@"
}

ASSERT_FALSE() {
  ASSERT EXPECT_FALSE "$@"
}
