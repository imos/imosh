test::compare_string() {
  if [[ ! ' b' < 'a' ]]; then
    LOG ERROR 'string comparation is bad: [[ " b" < "a" ]]'
  fi
  if [ ! ' b' \< 'a' ]; then
    LOG ERROR 'string comparation is bad: [ " b" < "a" ]'
  fi
  if [[ ! $'\n' < ' ' ]]; then
    LOG ERROR 'string comparation is bad: [[ "\n" < " " ]]'
  fi
  if [ ! $'\n' \< ' ' ]; then
    LOG ERROR 'string comparation is bad: [ "\n" < " " ]'
  fi
  if [[ ! 'A' < 'a' ]]; then
    LOG ERROR 'string comparation is bad: [[ "A" < "a" ]]'
  fi
  if [ ! 'A' \< 'a' ]; then
    LOG ERROR 'string comparation is bad: [ "A" < "a" ]'
  fi
  if [[ ! 'a' < 'aa' ]]; then
    LOG ERROR 'string comparation is bad: [[ "a" < "aa" ]]'
  fi
  if [ ! 'a' \< 'aa' ]; then
    LOG ERROR 'string comparation is bad: [ "a" < "aa" ]'
  fi
}
