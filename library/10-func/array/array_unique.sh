# func::array_unique -- Removes duplicated elements from an array variable.
#
# func::array_unique sorts elements first and removes duplicated elements.
#
# Usage:
#     // 1. Function form.
#     void func::array_unique(string[]* variable)
#     // 2. Stream form.
#     void stream::array_unique() < input > output
#
# Example:
#     a=(c b a b)
#     func::array_unique a
#     echo "${a[@]}"  # => a b c
#
#     echo c b a b | stream::array_unique  # => a b c
#
#     echo c,b,a,b | IFS=, stream::array_unique  # => a,b,c
func::array_unique() {
  local __array_unique_variable="${1}"
  if eval "[ \"\${#${__array_unique_variable}[*]}\" -eq 0 ]"; then
    return
  fi
  eval "local __array_unique_values=(\"\${${__array_unique_variable}[@]}\")"
  func::sort __array_unique_values
  local __array_unique_i=0
  local __array_unique_size="${#__array_unique_values[*]}"
  local __array_unique_result=("${__array_unique_values[0]}")
  while (( __array_unique_i += 1, __array_unique_i < __array_unique_size )); do
    if [ "${__array_unique_values[$(( __array_unique_i - 1 ))]}" != \
         "${__array_unique_values[${__array_unique_i}]}" ]; then
      __array_unique_result+=("${__array_unique_values[${__array_unique_i}]}")
    fi
  done
  eval "${__array_unique_variable}=(\"\${__array_unique_result[@]}\")"
}

stream::array_unique() {
  local line=''
  while IFS= read -r line; do
    local values=(${line})
    func::array_unique values
    func::println "${values[*]}"
  done
}
