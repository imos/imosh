php::md5() {
  if which openssl >/dev/null 2>/dev/null; then
    print "${1}" | openssl md5 -binary | func::bin2hex
  elif which md5sum >/dev/null 2>/dev/null; then
    print "${1}" | md5sum -b | func::bin2hex
  else
    LOG FATAL 'no command for md5 is found.'
  fi
}
