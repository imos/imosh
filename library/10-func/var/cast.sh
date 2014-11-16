# cast -- Casts a variable.
#
# Casts variable into a specified type.
#
# Usage:
#     bool func::cast(variant* variable, string type)
func::cast() {
  if [ "$#" -eq 2 ]; then
    case "${2}" in
      multi*)
        local __cast_values=()
        local __cast_element_type="${2:5}"
        func::array_values __cast_values "${1}"
        if [ "${#__cast_values[*]}" -ne 0 ]; then
          local __cast_index=0
          for __cast_index in "${!__cast_values[@]}"; do
            local __cast_value="${__cast_values[${__cast_index}]}"
            func::cast __cast_value "${__cast_element_type}" || return "$?"
            __cast_values["${__cast_index}"]="${__cast_value}"
          done
        fi
        func::array_values "${1}" __cast_values
        ;;
      int)     func::intval "${1}" || return "$?";;
      float)   func::floatval "${1}" || return "$?";;
      string)  func::strval "${1}" || return "$?";;
      bool)    func::boolval "${1}" || return "$?";;
      variant) return 0;;
      *)       LOG FATAL "Unknown type: ${2}";;
    esac
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

func::cast_or_die() {
  if ! func::cast "${@}"; then
    IFS=' ' eval 'LOG FATAL "Type mismatch: ${*}"'
  fi
}
