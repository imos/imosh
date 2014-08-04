php::addslashes() {
  if [ "$#" -ne 1 ]; then
    LOG FATAL 'php::addslashes requires one argument.'
  fi

  local subject="${1}"
  subject="$(php::str_replace '\' '\\' "${subject}")"
  subject="$(php::str_replace "'" "\\'" "${subject}")"
  print "${subject}"
}
