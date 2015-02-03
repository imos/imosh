run_date() {
  EXPECT_EQ '1136160000' "$(TZ=UTC sub::strtotime "${1}")"
  EXPECT_EQ '1136127600' "$(TZ=Asia/Tokyo sub::strtotime "${1}")"
}

run_datetime() {
  EXPECT_EQ '1136214245' "$(TZ=UTC sub::strtotime "${1}")"
  EXPECT_EQ '1136181845' "$(TZ=Asia/Tokyo sub::strtotime "${1}")"
}

run_fixed_datetime() {
  EXPECT_EQ '1136214245' "$(TZ=UTC sub::strtotime "${1}")"
  EXPECT_EQ '1136214245' "$(TZ=Asia/Tokyo sub::strtotime "${1}")"
}

test::strtotime() {
  # Proposed new HTTP format.
  run_date '02 Jan 2006'
  # Old RFC850 HTTP format.
  run_date '02-Jan-06'
  # Broken RFC850 HTTP format.
  run_date '02-Jan-2006'
  # Common logfile format.
  run_date '02/Jan/2006'
  # ISO 8601 compact date format.
  run_date '20060102'
  # ISO 8601 date format.
  run_date '2006-01-02'
  # UNIX ls format.
  run_date 'Jan 2 2006'
  # English date format.
  run_date 'Jan 2, 2006'
  # Japanese date format.
  run_date '2006/01/02'

  # ISO 8601 format without timezone.
  run_datetime '2006-01-02 15:04:05'
  # ISO 8601 format with a T separator.
  run_datetime '2006-01-02T15:04:05'
  # Compact datetime format.
  run_datetime '20060102150405'
  # HTTP format without timezone.
  run_datetime 'Mon, 02 Jan 2006 15:04:05'
  run_datetime '02 Jan 2006 15:04:05'
  # Japanese datetime format.
  run_datetime '2006/01/02 15:04:05'

  # HTTP format.
  run_fixed_datetime 'Mon, 02 Jan 2006 15:04:05 GMT'
  run_fixed_datetime 'Mon, 02 Jan 2006 15:04:05 +0000'
  run_fixed_datetime '02 Jan 2006 15:04:05 GMT'
  run_fixed_datetime 'Tue, 03 Jan 2006 00:04:05 +0900'
  run_fixed_datetime 'Tue, 03 Jan 2006 00:04:05 JST'
  # Old RFC850 HTTP format.
  run_fixed_datetime 'Monday, 02-Jan-06 15:04:05 GMT'
  run_fixed_datetime 'Monday, 02-Jan-2006 15:04:05 GMT'
  # Common logfile format.
  run_fixed_datetime '03/Jan/2006:00:04:05 +0900'
  # ISO 8601 format.
  run_fixed_datetime '2006-01-02 15:04:05 +0000'
  run_fixed_datetime '2006-01-03 00:04:05 +0900'
  run_fixed_datetime '2006-01-02T15:04:05Z'
  run_fixed_datetime '2006-01-03T00:04:05+0900'
  run_fixed_datetime '2006-01-03T00:04:05+09:00'
  # UNIX timestamp format.
  run_fixed_datetime '1136214245'
  run_fixed_datetime '@1136214245'
}
