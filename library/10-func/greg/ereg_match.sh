# ereg_match -- Checks if a string matches an EREG pattern.
#
# ereg_match checks if a string matches an EREG pattern.
#
# Usage:
#     // 1. Command form.
#     bool sub::ereg_match(string pattern, string subject)
sub::ereg_match() {
  if [ "$#" -eq 2 ]; then
    if [[ "${2}" =~ $1 ]]; then
      return 0
    else
      return 1
    fi
  elif [ "$#" -eq 3 ]; then
    if [[ "${2}" =~ $1 ]]; then
      func::array_values "${3}" BASH_REMATCH
      return 0
    else
      return 1
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
