test::func_getmypid() {
  local pid=''
  func::getmypid pid
  EXPECT_NE '' "${pid}"
  EXPECT_TRUE func::greg_match '[1-9]*([0-9])' "${pid}"

  local child_pid="$(func::getmypid pid; echo "${pid}")"
  EXPECT_NE "${pid}" "${child_pid}"
  EXPECT_TRUE func::greg_match '[1-9]*([0-9])' "${child_pid}"
}
