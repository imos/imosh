php::rand() {
  if [ "$#" -eq 0 ]; then
    php::rand 0 2147483647
    return
  fi
  if [ "$#" -ne 2 ]; then
    LOG FATAL 'php::rand requires zero or two arguments.'
  fi

  local min="${1}" max="${2}" range=0
  (( range = max - min + 1 )) || true
  if [ "${range}" -lt 1 ]; then
    LOG FATAL "min must be larger than max: min=${min}, max=${max}"
  fi
  if [ "${range}" -eq 1 ]; then
    print "${min}"
    return
  fi
  local rand=0
  (( rand = RANDOM ^ (RANDOM << 8) ^
            (RANDOM << 16) ^ (RANDOM << 24) ^
            (RANDOM << 32) ^ (RANDOM << 40) ^
            (RANDOM << 48) ^ (RANDOM << 56) )) || true
  (( rand = min + ( rand % range + range ) % range )) || true
  print "${rand}"
}
