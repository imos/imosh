# array_unique -- Removes duplicated elements from an array variable.
#
# array_unique sorts elements first and removes duplicated elements.  Function
# form applies array_unique to the given variable.  Stream form applies
# array_unique to every line.  Every line is treated as elements.
#
# Usage:
#     // 1. Function form.
#     void func::array_unique(string[]* variable)
#     // 2. Stream form.
#     void stream::array_unique() < input > output
#
# Examples:
#     a=(c b a b)
#     func::array_unique a
#     echo "${a[@]}"  # => a b c
#
#     echo c b a b | stream::array_unique  # => a b c
#
#     echo c,b,a,b | IFS=, stream::array_unique  # => a,b,c
func::array_unique() {
  if [ "$#" -eq 1 ]; then
    if sub::array_is_empty "${1}"; then return; fi
    local __array_unique_values=()
    func::array_values __array_unique_values "${1}"
    func::sort __array_unique_values
    local __array_unique_i="${#__array_unique_values[*]}"
    while (( __array_unique_i -= 1 )); do
      if [ "${__array_unique_values[$(( __array_unique_i - 1 ))]}" = \
           "${__array_unique_values[${__array_unique_i}]}" ]; then
        unset "__array_unique_values[${__array_unique_i}]"
      fi
    done
    func::array_values "${1}" __array_unique_values
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

stream::array_unique() {
  if [ "$#" -eq 0 ]; then
    stream::array_map ARRAY func::array_unique
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
