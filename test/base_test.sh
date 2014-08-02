# CAVEATS:
#     Some versions of BASH 4 have a bug around string comparation using double
#     brackets.
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

# CAVEATS:
#     BASH 3 has a bug: $'\x01' in array is treated as $'\x01\x01'.
test::soh_in_array() {
  local values=($'\x01')
  local expected='01'
  if [ "${expected}" != "$(php::bin2hex "$(php::implode '' values)")" ]; then
    LOG ERROR 'soh cannot be treated in array correctly:' \
              "$(php::bin2hex "$(php::implode '' values)")"
  fi
}
