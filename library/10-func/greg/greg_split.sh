# func::greg_split -- Splits a string with a GREG pattern.
#
# greg_split splits a string with a GREG pattern.
#
# Usage:
#     void func::greg_split(string* variable, string pattern, string value)
func::greg_split() {
  if [ "$#" -eq 3 ]; then
    local __greg_split_variable="$1"
    local __greg_split_pattern="$2"
    local __greg_split_value="$3"

    func::greg_replace __greg_split_value "${__greg_split_pattern}" $'\x02'
    func::explode "${__greg_split_variable}" $'\x02' "${__greg_split_value}"
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
