test::isset() {
  if php::isset undefined_variable; then
    LOG FATAL "undefined_variable should return false"
  fi
  local defined_variable=value
  if ! php::isset defined_variable; then
    LOG FATAL "defined_variable should return true"
  fi
  defined_variable=
  if ! php::isset defined_variable; then
    LOG FATAL "defined_variable should return true"
  fi
  local null_variable=
  if ! php::isset null_variable; then
    LOG FATAL "null_variable should return true"
  fi
  # isset's behavior for uninitialized variables is different in BASH versions.
  # local uninitialized_variable
  # if ! php::isset uninitialized_variable; then
  #   LOG FATAL "uninitialized_variable should return true"
  # fi
}
