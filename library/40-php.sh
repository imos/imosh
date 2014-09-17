__IMOSH_PHP_EXECUTER_PID=''

php::internal::kill() {
  if (( FLAGS_disown_php )); then
    if [ "${__IMOSH_PHP_EXECUTER_PID}" = "$$" ]; then
      # Make sure that the target process exists.
      if kill -0 "$(cat "${__IMOSH_PHP_PID}")" 2>/dev/null; then
        php::internal::run 'exit(0);'
        kill -TERM "$(cat "${__IMOSH_PHP_PID}")" 2>/dev/null
      fi
    fi
  fi
}

php::internal::run() {
  local __php_code="$1"
  local __php_name=''
  if [ "$#" -ge 2 ]; then __php_name="$2"; fi

  local __php_line __php_return_code
  local __php_new_line=$'\n'
  __php_code="${__php_code//@/@@}"
  __php_code="${__php_code//${__php_new_line}/@n}"
  if (( FLAGS_disown_php )); then
    php::internal::start
    printf "%s\n" "${__php_code}" >&111
    read __php_line <&110
    read __php_return_code <&110
  else
    while :; do
      read __php_line
      read __php_return_code
      break
    done < <(printf "%s\n" "${__php_code}" |  php::internal::start)
  fi

  if [ "${__php_name}" != '' ]; then
    eval "${__php_name}=${__php_line//@/\\}"
  fi
  if [ "${__php_return_code}" = '' ]; then return 1; fi
  return "${__php_return_code}"
}

php::internal::start() {
  if (( FLAGS_disown_php )); then
    if [ "${__IMOSH_PHP_EXECUTER_PID}" = "$$" ]; then
      # Make sure that the target process exists.
      if kill -0 "$(cat "${__IMOSH_PHP_PID}")" 2>/dev/null; then
        return;
      fi
    fi
    exec 111>&- 110<&-
    __IMOSH_PHP_STDIN="$(mktemp "${__IMOSH_CORE_TMPDIR}/php_stdin.XXXXXX")"
    __IMOSH_PHP_STDOUT="$(mktemp "${__IMOSH_CORE_TMPDIR}/php_stdout.XXXXXX")"
    __IMOSH_PHP_EXECUTER_PID="$$"
    __IMOSH_PHP_PID="$(mktemp "${__IMOSH_CORE_TMPDIR}/php_pid.XXXXXX")"
    rm "${__IMOSH_PHP_STDIN}" "${__IMOSH_PHP_STDOUT}"
  fi
  local php_script="$(mktemp "${__IMOSH_CORE_TMPDIR}/php_script.XXXXXX")"
  cat << 'EOM' >"${php_script}"
<?php

function imosh_chop($str) { return substr($str, 0, strlen($str) - 1); }

$translate = array(
  "\r" => '@r', "\n" => '@n', '\\' => '@@',
  '"' => '@x22', "'" => "@x27", '@' => '@x40');

while (($line = fgets(STDIN)) !== FALSE) {
  $line = strtr($line, array('@@' => '@', '@n' => "\n"));
  ob_start();
  $value = eval($line);
  $output = ob_get_clean();
  echo "\$'" . strtr($output, $translate) . "'\n";
  echo intval($value) . "\n";
  if (isset($argv[1]) && $argv[1] == 'once') exit(0);
}

EOM
  LOG INFO 'Starting to run php...'
  if (( ! FLAGS_disown_php )); then
    php "${php_script}" once
    return
  fi
  mkfifo "${__IMOSH_PHP_STDIN}"
  mkfifo "${__IMOSH_PHP_STDOUT}"
  bash -c "nohup php '${php_script}' \
               <'${__IMOSH_PHP_STDIN}' \
               >'${__IMOSH_PHP_STDOUT}' &
           echo \$! >'${__IMOSH_PHP_PID}'"
  LOG INFO "Opening PHP's STDIN..."
  exec 111>"${__IMOSH_PHP_STDIN}"
  LOG INFO "Opening PHP's STDOUT..."
  exec 110<"${__IMOSH_PHP_STDOUT}"
}

php::stop() {
  php::internal::kill
}

php::start() {
  if (( FLAGS_disown_php )); then
    php::internal::start
  fi
}
