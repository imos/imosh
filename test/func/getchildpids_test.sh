test::func_getchildpids() {
  local pids=()
  func::getchildpids pids
  EXPECT_TRUE [ "${#pids[*]}" -le 1 ]

  local child_pids=()
  for i in {1..10}; do
    sleep 10 &
    child_pids+=("$!")
  done
  func::getchildpids pids
  EXPECT_TRUE [ "${#pids[*]}" -ge 10 -a "${#pids[*]}" -le 11 ]

  for child_pid in "${child_pids[@]}"; do
    kill -9 "${child_pid}"
  done
}
