# func::implode -- Joins array elements with a string.
#
# func::implode joins `pieces` with `glue`.
# *Stream form* uses the IFS environment variable as an input separator and
# processes line by line.
#
# Usage:
#     // 1. Function form.
#     void func::implode(string* variable, string glue, string[]* pieces)
#     // 2. Command form.
#     void func::implode(string glue, string[]* pieces) > result
#     // 3. Stream form.
#     void func::implode(string glue) < input > output
#
# Alias:
#   func::join is an alias of func::implode.
func::implode() {
  # 1. Function form.
  if [ "$#" -eq 3 ]; then
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
  # 2. Command form
  elif [ "$#" -eq 2 ]; then
    local __implode_output=''
    # 1. Function form.
    func::implode __implode_output "$1" "$2"
    func::println "${__implode_output}"
    return
  # 3. Stream form.
  elif [ "$#" -eq 1 ]; then
    local __implode_line=''
    while read -r __implode_line; do
      local pieces=(${__implode_line})
      # 2. Command form.
      func::implode "$1" pieces
    done
    return
  # Argument mismatch.
  else
    LOG ERROR "The number of arguments does not match func::implode: $#"
    return 1
  fi
}

func::join() { func::implode "$@"; }
