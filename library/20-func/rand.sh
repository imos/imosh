# Usage:
#   void func::rand(int* variable)
#   void func::rand(int* variable, int minimum, int maximum)
#
# Generates a random integer.
func::rand() {
  if [ "$#" -eq 1 ]; then
    func::rand "$1" 0 2147483647
    return
  fi
  if [ "$#" -ne 3 ]; then
    LOG FATAL 'func::rand requires one or three arguments.'
  fi

  local __rand_variable="$1"
  local __rand_minimum="$2"
  local __rand_maximum="$3"
  local __rand_range=0 __rand_value=0
  if (( __rand_minimum > __rand_maximum )); then
    LOG FATAL "minimum must be larger than maximum:" \
              "minimum=${__rand_minimum}, maximum=${__rand_maximum}"
  fi
  (( __rand_value = RANDOM ^ (RANDOM << 8) ^
                    (RANDOM << 16) ^ (RANDOM << 24) ^
                    (RANDOM << 32) ^ (RANDOM << 40) ^
                    (RANDOM << 48) ^ (RANDOM << 56),
     __rand_range = __rand_maximum - __rand_minimum + 1,
     __rand_value = __rand_minimum +
         ( __rand_value % __rand_range + __rand_range ) % __rand_range,
     1 ))
  func::let "${__rand_variable}" "${__rand_value}"
}
