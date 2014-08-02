php::isset() {
  local variable_name="$1"

  if [ "$(eval echo '${'"${variable_name}"'+set}')" == '' ]; then
    return 1
  fi
  return 0
}
