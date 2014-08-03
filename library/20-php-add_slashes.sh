php::addslashes() {
  if [ "$#" -ne 1 ]; then
    LOG FATAL 'php::addslashes requires one argument.'
  fi

  php::str_replace "'" "\\'" "$(php::str_replace '\' '\\' "${1}")"
}
