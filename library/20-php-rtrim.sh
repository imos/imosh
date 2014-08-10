php::rtrim() {
  local value="$*"
  print "${value%"${value##*[![:space:]]}"}"
}
