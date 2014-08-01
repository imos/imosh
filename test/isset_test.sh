test::isset() {
  if isset undefined_variable; then
    LOG FATAL "undefined_variable should return false"
  fi
  local defined_variable=value
  if ! isset defined_variable; then
    LOG FATAL "defined_variable should return true"
  fi
  defined_variable=
  if ! isset defined_variable; then
    LOG FATAL "defined_variable should return true"
  fi
}
