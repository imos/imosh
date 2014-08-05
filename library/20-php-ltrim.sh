php::ltrim() {
  local value="$*"
  print "${value#"${value%%[![:space:]]*}"}"
}
