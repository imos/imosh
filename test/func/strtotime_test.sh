run_date() {
  EXPECT_EQ '1136160000' "$(TZ=UTC sub::strtotime "${1}")"
  EXPECT_EQ '1136127600' "$(TZ=Asia/Tokyo sub::strtotime "${1}")"
}

run_datetime() {
  EXPECT_EQ '1136214245' "$(TZ=UTC sub::strtotime "${1}")"
  EXPECT_EQ '1136181845' "$(TZ=Asia/Tokyo sub::strtotime "${1}")"
}

test::strtotime() {
  run_date '2006-01-02'
  run_date '2006/01/02'
  run_datetime '2006-01-02 15:04:05'
  run_datetime '2006-01-02T15:04:05'
  run_datetime '2006/01/02 15:04:05'
}
