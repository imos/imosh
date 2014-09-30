# func::array_unique -- Remove duplicated elements from an array variable.
#
# Usage:
#   void func::array_unique(string[]* variable)
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
