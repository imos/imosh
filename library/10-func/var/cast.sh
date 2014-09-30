# func::cast -- Casts a variable.
#
# Usage:
#   bool func::cast(variant* variable, string type)
#
# Casts variable into a specified type.
func::cast() {
  local __cast_variable="$1"
  local __cast_type="$2"

  case "${__cast_type}" in
    int)     if ! func::intval "${__cast_variable}"; then return 1; fi;;
    float)   if ! func::floatval "${__cast_variable}"; then return 1; fi;;
    string)  if ! func::strval "${__cast_variable}"; then return 1; fi;;
    bool)    if ! func::boolval "${__cast_variable}"; then return 1; fi;;
    variant) return 0;;
    *)       LOG FATAL "Unknown type: ${__cast_type}";;
  esac
}
