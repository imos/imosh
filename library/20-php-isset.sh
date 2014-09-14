# CAVEATS:
#     isset returns true for uninitialized variables in BASH 3, and returns
#     false for them in BASH 4.
php::isset() {
  local variable_name="$1"

  if [ "$(eval echo '${'"${variable_name}"'+set}')" = '' ]; then
    return 1
  fi
  return 0
}
