php::array_unique() {
  if [ "$#" -ne 1 ]; then
    LOG FATAL 'php::array_unique requires one argument.'
  fi

  local __array_unique_name="${1}"
  eval "local __array_unique_values=(\"\${${__array_unique_name}[@]}\")"
  php::sort __array_unique_values
  local __array_unique_i=1 __array_unique_size="${#__array_unique_values[@]}"
  while (( __array_unique_i < __array_unique_size )); do
    local __array_unique_last_i=0
    (( __array_unique_last_i = __array_unique_i - 1 )) || true
    if [ "${__array_unique_values[${__array_unique_i}]}" == \
         "${__array_unique_values[${__array_unique_last_i}]}" ]; then
      unset __array_unique_values["${__array_unique_last_i}"]
    fi
    (( __array_unique_i += 1 )) || true
  done
  eval "${__array_unique_name}=(\"\${__array_unique_values[@]}\")"
}
