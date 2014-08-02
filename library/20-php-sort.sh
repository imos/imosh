php::internal::set_pivot() {
  local pivot_index
  (( pivot_index = left + (right - left) / 2 ))
  local x="${__sort_values[${left}]}"
  local y="${__sort_values[${pivot_index}]}"
  local z="${__sort_values[${right}]}"

  if [[ "${x}" < "${y}" ]]; then
    if [[ "${y}" < "${z}" ]]; then
      pivot="${y}"
    elif [[ "${z}" < "${x}" ]]; then
      pivot="${x}"
    else
      pivot="${z}"
    fi
  else
    if [[ "${z}" < "${y}" ]]; then
      pivot="${y}"
    elif [[ "${x}" < "${z}" ]]; then
      pivot="${x}"
    else
      pivot="${z}"
    fi
  fi
}

php::internal::quick_sort() {
  local left="${1}" right="${2}"
  local i="${left}" j="${right}"
  if [ "${left}" -ge "${right}" ]; then return; fi
  local pivot
  php::internal::set_pivot
  while :; do
    while [[ "${__sort_values[${i}]}" < "${pivot}" ]]; do (( i += 1 )); done
    while [[ "${pivot}" < "${__sort_values[${j}]}" ]]; do (( j -= 1 )); done
    if [ "${i}" -ge "${j}" ]; then break; fi
    local value="${__sort_values[${i}]}"
    __sort_values["${i}"]="${__sort_values[${j}]}"
    __sort_values["${j}"]="${value}"
    (( i += 1 ))
    (( j -= 1 ))
  done
  (( i -= 1 ))
  (( j += 1 ))
  php::internal::quick_sort "${left}" "${i}"
  php::internal::quick_sort "${j}" "${right}"
}

php::sort() {
  local __sort_name="${1}"
  eval "local __sort_values=(\"\${${__sort_name}[@]}\")"
  local __sort_size="${#__sort_values[@]}"
  (( __sort_size -= 1 ))
  php::internal::quick_sort 0 "${__sort_size}"
  eval "${__sort_name}=(\"\${__sort_values[@]}\")"
}
