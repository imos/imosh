# rand -- Generates a random integer.
#
# rand generates a random integer.
#
# Usage:
#     // 1. Function form.
#     void func::rand(int* variable, int minimum, int maximum)
#     void func::rand(int* variable, int maximum)
#     void func::rand(int* variable)
#     // 2. Command form.
#     void sub::rand(int minimum, int maximum) > output
#     void sub::rand(int maximum) > output
#     void sub::rand() > output
func::rand() {
  if [ "$#" -eq 3 ]; then
    local __rand_value=0
    __func::rand "${2}" "${3}"
    func::let "${1}" "${__rand_value}"
  elif [ "$#" -eq 2 ]; then
    func::rand "${1}" 0 "${2}"
  elif [ "$#" -eq 1 ]; then
    func::rand "${1}" 2147483647
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::rand() {
  if [ "$#" -le 2 ]; then
    local __rand_variable=0
    func::rand __rand_variable "$@"
    sub::println "${__rand_variable}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

__func::rand() {
  local min="${1}" max="${2}" range=0
  if [ "${min}" -eq "${max}" ]; then
    __rand_value="${min}"
    return
  elif [ "${min}" -gt "${max}" ]; then
    local min="${max}" max="${min}"
  fi
  (( __rand_value = RANDOM ^ (RANDOM << 8) ^ (RANDOM << 16) ^ (RANDOM << 24) ^
         (RANDOM << 32) ^ (RANDOM << 40) ^ (RANDOM << 48) ^ (RANDOM << 56),
     range = max - min + 1,
     __rand_value = min + (__rand_value % range + range) % range )) || true
}
