test::func_tmpfile() {
  local files=()
  local tmpfile=''

  # Test tmpfile's destribution.
  for i in {1..100}; do
    func::tmpfile tmpfile
    files+=("${tmpfile}")
  done
  func::array_unique files
  EXPECT_EQ 100 "${#files[@]}"

  # 1. Function form.
  func::tmpfile tmpfile
  echo foo > "${tmpfile}"
  EXPECT_EQ 'foo' "$(cat "${tmpfile}")"

  # 2. Command form.
  tmpfile="$(func::tmpfile)"
  echo bar > "${tmpfile}"
  EXPECT_EQ 'bar' "$(cat "${tmpfile}")"
}
