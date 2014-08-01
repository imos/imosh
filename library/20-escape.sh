imosh::shell_escape() {
  local arg
  local search="'"
  local replace="'\"'\"'"
  for arg in "$@"; do
    arg="${arg//${search}/${replace}}"
    echo -n "'${arg}'"
  done
}
