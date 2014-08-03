php::preg_match() {
  local __preg_match_pattern="${1}"
  local __preg_match_subject="${2}"
  local __preg_match_name=''

  if [ "$#" -ge 3 ]; then __preg_match_name="${3}"; fi
  local __preg_match_result="$(php << EOM 
<?php
if (version_compare(PHP_VERSION, '5.2.4') >= 0) {
  ini_set('display_errors', 'stderr');
} else {
  error_reporting(0);
}

if (preg_match('$(php::addslashes "${__preg_match_pattern}")',
               '$(php::addslashes "${__preg_match_subject}")',
               \$match)) {
  echo '1' . implode("\\x02", \$match);
} else {
  echo '0';
}
EOM
  )"
  if [ "${__preg_match_result}" == '0' ]; then
    return 1
  fi
  if [ "${__preg_match_name}" != '' ]; then
    __preg_match_result="${__preg_match_result:1}"
    php::explode "${__preg_match_name}" $'\x02' "${__preg_match_result}"
  fi
}
