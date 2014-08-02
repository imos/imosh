test::compare_string() {
  if [[ ! ' b' < 'a' ]]; then
    LOG FATAL 'string comparation is bad: " b" < "a"'
  fi
  if [[ ! $'\n' < ' ' ]]; then
    LOG FATAL 'string comparation is bad: "\n" < " "'
  fi
  if [[ ! 'A' < 'a' ]]; then
    LOG FATAL 'string comparation is bad: "A" < "a"'
  fi
  if [[ ! 'a' < 'aa' ]]; then
    LOG FATAL 'string comparation is bad: "a" < "aa"'
  fi
}
