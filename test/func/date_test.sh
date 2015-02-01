test::strtotime() {
  EXPECT_EQ '2006-01-02 15:04:05' \
            "$(TZ=UTC sub::date 'Y-m-d H:i:s' 1136214245)"
  EXPECT_EQ '2006-01-03 00:04:05' \
            "$(TZ=Asia/Tokyo sub::date 'Y-m-d H:i:s' 1136214245)"
  EXPECT_EQ 'January 3, 2006, 12:04 AM' \
            "$(TZ=Asia/Tokyo sub::date 'F j, Y, g:i a' 1136214245)"
  EXPECT_EQ '00:01:05 m is month' \
            "$(TZ=Asia/Tokyo sub::date 'H:m:s \m \i\s\ \m\o\n\t\h' 1136214245)"
  EXPECT_EQ '2006-01-03T00:04:05+09:00' \
            "$(TZ=Asia/Tokyo sub::date 'c' 1136214245)"
  EXPECT_EQ 'Tue, 03 Jan 2006 00:04:05 +0900' \
            "$(TZ=Asia/Tokyo sub::date 'r' 1136214245)"
  EXPECT_EQ '1136214245' \
            "$(TZ=Asia/Tokyo sub::date 'U' 1136214245)"
}
