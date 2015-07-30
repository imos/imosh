# in_array -- Checks if a value exists in an array.
#
# Searches haystack for needle.
#
# Usage:
#     // 1. Command form.
#     bool sub::in_array(string needle, string[]* haystack)
sub::in_array() {
  if [ "$#" -eq 2 ]; then
    if sub::array_is_empty "${2}"; then
      return 1
    fi
    eval "
        for value in \"\${${2}[@]}\"; do
          if [ \"\${value}\" == \"\${1}\" ]; then
            return
          fi
        done"
    return 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
