# Usage:
#   php::str_replace <search> <replace> <subject>
php::str_replace() {
  local search="${1}"
  local replace="${2}"
  local subject="${3}"

  print "${subject//${search}/${replace}}"
}
