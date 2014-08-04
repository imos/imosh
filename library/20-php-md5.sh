php::md5() {
  if (( FLAGS_disown_php )); then
    local __php_output=''
    php::internal::run \
        "echo md5(imosh_chop('$(php::addslashes "${1};")'));" __php_output
    print "${__php_output}"
    return
  fi
  if which openssl >/dev/null 2>/dev/null; then
    print "${1}" | openssl md5 -binary | php::bin2hex
  elif which md5sum >/dev/null 2>/dev/null; then
    print "${1}" | md5sum -b | php::bin2hex
  else
    LOG FATAL 'no command for md5 is found.'
  fi
}
