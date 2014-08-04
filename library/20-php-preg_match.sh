php::preg_match() {
  local __preg_match_pattern="${1}"
  local __preg_match_subject="${2}"
  local __preg_match_name=''

  if [ "$#" -ge 3 ]; then __preg_match_name="${3}"; fi
  local __preg_match_result
  if ! php::internal::run "
      if (!preg_match('$(php::addslashes "${__preg_match_pattern}")',
                      '$(php::addslashes "${__preg_match_subject}")',
                      \$match)) { return 1; }
      echo implode(\"\\x02\", \$match); return 0;" __preg_match_result; then
    return 1
  else
    php::explode "${__preg_match_name}" $'\x02' "${__preg_match_result}"
  fi
}
