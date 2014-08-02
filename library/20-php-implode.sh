php::implode() {
  local __implode_delimiter="${1}"
  local __implode_name="${2}"

  eval "local __implode_values=(\"\${${__implode_name}[@]}\")"
  local __implode_size="${#__implode_values[@]}"
  local i=0
  local output=''
  while (( i < __implode_size )); do
    if (( i != 0 )); then output+="${__implode_delimiter}"; fi
    output+="${__implode_values[${i}]}"
    (( i += 1 )) || true
  done
  print "${output}"
}
