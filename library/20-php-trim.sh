php::trim() {
  local value="$*"
  print "$(php::ltrim "$(php::rtrim "${value}")")"
}
