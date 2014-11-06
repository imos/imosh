# func::cast -- Casts a variable.
#
# Casts variable into a specified type.
#
# Usage:
#     bool func::cast(variant* variable, string type)
func::cast() {
  local __cast_variable="${1}"
  local __cast_type="${2}"

  case "${__cast_type}" in
    multi*)
      local __cast_values=()
      local __cast_element_type="${__cast_type:5}"
      func::array_values __cast_values "${__cast_variable}"
      if [ "${#__cast_values[*]}" -ne 0 ]; then
        local __cast_index=0
        for __cast_index in "${!__cast_values[@]}"; do
          local __cast_value="${__cast_values[${__cast_index}]}"
          if ! func::cast __cast_value "${__cast_element_type}"; then
            return 1
          fi
          __cast_values["${__cast_index}"]="${__cast_value}"
        done
      fi
      func::array_values "${__cast_variable}" __cast_values
      ;;
    int)     if ! func::intval "${__cast_variable}"; then return 1; fi;;
    float)   if ! func::floatval "${__cast_variable}"; then return 1; fi;;
    string)  if ! func::strval "${__cast_variable}"; then return 1; fi;;
    bool)    if ! func::boolval "${__cast_variable}"; then return 1; fi;;
    variant) return 0;;
    *)       LOG FATAL "Unknown type: ${__cast_type}";;
  esac
}

func::cast_or_die() {
  if ! func::cast "${@}"; then
    IFS=' ' eval 'LOG FATAL "Type mismatch: ${*}"'
  fi
}
