test::func_rand() {
  local values=() value=0
  for i in {1..100}; do
    func::rand value
    if [ 0 -le "${value}" -a "${value}" -le 2147483647 ]; then
      values+=("${value}")
    else
      LOG FATAL 'func::rand should be between 0 and 2147483647 inclusive:' \
                "${value}"
    fi
  done
  func::array_unique values
  if [ "${#values[@]}" -lt 98 ]; then
    LOG FATAL "func::rand's distribution may be bad: ${#values[@]}"
  fi
  values=()
  for i in {1..100}; do
    func::rand value 0 4
    if [ 0 -le "${value}" -a "${value}" -le 4 ]; then
      values+=("${value}")
    else
      LOG FATAL "func::rand(0, 4) should be between 0 and 4 inclusive: ${value}"
    fi
  done
  func::array_unique values
  # This should pass in 99.999999898148%.
  if [ "${#values[@]}" -ne 5 ]; then
    LOG FATAL "func::rand's distribution may be bad: ${#values[@]}"
  fi
}
