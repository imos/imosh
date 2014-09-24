# Enables error checking if imosh is called in a script.
if ! shopt login_shell >/dev/null; then
  # Make a script fail when
  # - a command returns non-zero value (-e).
  # - an undefined variable is referred (-u).
  set -e -u
  # Return if imosh is reloaded.
  if [ "${__IMOSH_IS_LOADED+loaded}" = 'loaded' ]; then
    return
  fi
fi
