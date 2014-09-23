test::func_sort() {
  local values=()
  EXPECT_TRUE func::sort values

  local values=('a')
  EXPECT_TRUE func::sort values
  EXPECT_EQ "a" "$(echo "${values[@]}")"

  local values=('b' 'a')
  EXPECT_TRUE func::sort values
  EXPECT_EQ "a b" "$(echo "${values[@]}")"

  local values=(w a c m d i n v y u q j g r x t z k h s e l o f b p)
  EXPECT_TRUE func::sort values
  EXPECT_EQ "a b c d e f g h i j k l m n o p q r s t u v w x y z" \
            "$(echo "${values[@]}")"

  local values=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
  EXPECT_TRUE func::sort values
  EXPECT_EQ "1 10 11 12 13 14 15 16 17 18 19 2 20 3 4 5 6 7 8 9" \
            "$(echo "${values[@]}")"

  local i=1
  local c1=$'\x01'
  local values=($'\x1a' $'\x11' "${c1}" $'\x16' $'\x09' $'\x03' $'\x1c' $'\x05'
                $'\x1d' $'\x1b' $'\x0a' $'\x19' $'\x1e' $'\x0e' $'\x15' $'\x0f'
                $'\x0d' $'\x08' $'\x04' $'\x13' $'\x02' $'\x07' $'\x1f' $'\x0c'
                $'\x17' $'\x18' $'\x20' $'\x10' $'\x06' $'\x0b' $'\x12' $'\x14')
  IFS= EXPECT_TRUE func::sort values
  local expected=''
  expected+=$'\x01 \x02 \x03 \x04 \x05 \x06 \x07 \x08 '
  expected+=$'\x09 \x0a \x0b \x0c \x0d \x0e \x0f \x10 '
  expected+=$'\x11 \x12 \x13 \x14 \x15 \x16 \x17 \x18 '
  expected+=$'\x19 \x1a \x1b \x1c \x1d \x1e \x1f \x20'
  EXPECT_EQ "$(func::bin2hex "${expected}")" \
            "$(func::bin2hex "$(func::implode ' ' values)")"

  IFS= EXPECT_TRUE func::sort values
  EXPECT_EQ "$(func::bin2hex "${expected}")" \
            "$(func::bin2hex "$(func::implode ' ' values)")"
}
