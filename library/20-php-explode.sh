php::explode() {
  local __explode_name="${1}"
  local __explode_delimiter="${2}"
  local __explode_value="${3}"

  __explode_value="$(
      php::str_replace "${__explode_delimiter}" $'\x02' "${__explode_value}")"
  eval "IFS=\$'\\x02' ${__explode_name}=(\$__explode_value)"
}
