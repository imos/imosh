test::php::rand() {
  local values=() value=0
  for i in {0..100}; do
    value="$(php::rand)"
    if [ 0 -le "${value}" -a "${value}" -le 2147483647 ]; then
      values+=("${value}")
    else
      LOG FATAL "php::rand should be between 0 and 2147483647: ${value}"
    fi
  done
  values=()
  for i in {0..100}; do
    value="$(php::rand 0 10)"
    if [ 0 -le "${value}" -a "${value}" -le 10 ]; then
      values+=("${value}")
    else
      LOG FATAL "php::rand(0,10) should be between 0 and 10: ${value}"
    fi
  done
}
