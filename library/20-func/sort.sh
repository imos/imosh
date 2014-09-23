__func::quick_sort() {
  local size="${#__sort_values[@]}"
  local pivot="${__sort_values[$(( size / 2 ))]}"
  local values1=() values2=() values3=()

  for value in "${__sort_values[@]}"; do
    if [ "${value}" \< "${pivot}" ]; then
      values1+=("${value}")
    elif [ "${value}" \> "${pivot}" ]; then
      values3+=("${value}")
    else
      values2+=("${value}")
    fi
  done
  func::sort values1
  func::sort values3
  __sort_values=()
  if [ "${#values1[*]}" -ne 0 ]; then
    __sort_values+=("${values1[@]}")
  fi
  if [ "${#values2[*]}" -ne 0 ]; then
    __sort_values+=("${values2[@]}")
  fi
  if [ "${#values3[*]}" -ne 0 ]; then
    __sort_values+=("${values3[@]}")
  fi
}

func::sort() {
  local __sort_name="${1}"
  eval "local __sort_size=\"\${#${__sort_name}[*]}\""
  if [ "${__sort_size}" -lt 2 ]; then
    return
  fi
  eval "local __sort_values=(\"\${${__sort_name}[@]}\")"
  __func::quick_sort
  eval "${__sort_name}=(\"\${__sort_values[@]}\")"
}
