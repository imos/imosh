# is_main -- Returns 0 iff caller is in the main script.
#
# Usage:
#     // 1. Command form.
#     void sub::is_main()
sub::is_main() {
  if [ "$#" -eq 0 ]; then
    local __is_main_depth="${#BASH_SOURCE[*]}"
    if [ "${BASH_SOURCE[0]}" = \
         "${BASH_SOURCE[$((__is_main_depth - 2))]}" ]; then
      return 0
    else
      return 1
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
