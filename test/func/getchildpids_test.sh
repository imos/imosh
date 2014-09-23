test::func_getchildpids() {
  local pids=()
  func::getchildpids pids
  EXPECT_EQ 0 "${#pids[*]}"

  sleep 10 &
  local child_pid="$!"
  func::getchildpids pids
  EXPECT_EQ 1 "${#pids[*]}"

  kill -9 "${child_pid}"
}
