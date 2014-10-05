# func::rand -- Generates a random integer.
#
# Generates a random integer.
#
# Usage:
#     // a. Function form.
#     void func::rand(int* variable)
#     // b. Function form with a range.
#     void func::rand(int* variable, int minimum, int maximum)
func::rand() {
  if [ "$#" -eq 3 ]; then
    local __rand_variable="$1"
    local __rand_minimum="$2"
    local __rand_maximum="$3"
    local __rand_range=0 __rand_value=0
    if (( __rand_minimum > __rand_maximum )); then
      LOG FATAL "minimum must be larger than maximum:" \
                "minimum=${__rand_minimum}, maximum=${__rand_maximum}"
    fi
    ((
      __rand_value = RANDOM ^ (RANDOM << 8) ^
                     (RANDOM << 16) ^ (RANDOM << 24) ^
                     (RANDOM << 32) ^ (RANDOM << 40) ^
                     (RANDOM << 48) ^ (RANDOM << 56),
      __rand_range = __rand_maximum - __rand_minimum + 1,
      __rand_value = __rand_minimum +
          ( __rand_value % __rand_range + __rand_range ) % __rand_range
    )) || true
    func::let "${__rand_variable}" "${__rand_value}"
  elif [ "$#" -eq 1 ]; then
    func::rand "$1" 0 2147483647
    return
  else
    LOG ERROR "Wrong number of arguments: $#"
    return 1
  fi
}
