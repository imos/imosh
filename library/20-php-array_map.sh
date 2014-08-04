php::array_map() {
  if [ "$#" -ne 2 ]; then
    LOG FATAL 'php::array_map requires two arguments.'
  fi

  local __array_map_callback="${1}"
  local __array_map_name="${2}"
  eval "local __array_map_values=(\"\${${__array_map_name}[@]}\")"
  local __array_map_i=0 __array_map_size="${#__array_map_values[@]}"
  while (( __array_map_i < __array_map_size )); do
    local __array_map_value="${__array_map_values[${__array_map_i}]}"
    __array_map_value="$("${__array_map_callback}" "${__array_map_value}")"
    eval "${__array_map_name}[${__array_map_i}]='$(
              php::addslashes "${__array_map_value}")'"
    (( __array_map_i += 1 )) || true
  done
}
