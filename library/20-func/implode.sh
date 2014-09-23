# func::implode -- Joins array elements with a string.
#
# Usage:
#   // 1. Function form.
#   void func::implode(string* variable, string glue, string[]* pieces)
#   // 2. Command form.
#   void func::implode(string glue, string[]* pieces) > result
#   // 3. Stream form.
#   void func::implode(string glue) < input > output
#
# Alias:
#   func::join is an alias of func::implode.
#
# func::implode joins `pieces` with `glue`.
# **Stream form** uses IFS as an input separator and processes line by line.
func::implode() {
  if [ "$#" -eq 1 ]; then
    local __implode_line=''
    while read -r __implode_line; do
      local pieces=(${__implode_line})
      func::implode "$1" pieces
    done
    return
  elif [ "$#" -eq 2 ]; then
    local __implode_output=''
    func::implode __implode_output "$1" "$2"
    func::println "${__implode_output}"
    return
  fi

  local __implode_variable="${1}"
  local __implode_glue="${2}"
  local __implode_pieces=()
  eval "local __implode_pieces=(\"\${${3}[@]}\")"

  local __implode_size="${#__implode_pieces[@]}"
  local __implode_i=0
  local __implode_result=''
  while (( __implode_i < __implode_size )); do
    if (( __implode_i != 0 )); then
      __implode_result+="${__implode_glue}"
    fi
    __implode_result+="${__implode_pieces[${__implode_i}]}"
    (( __implode_i += 1 )) || true
  done
  func::let "${__implode_variable}" "${__implode_result}"
}

func::join() { func::implode "$@"; }
