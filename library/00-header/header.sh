if ! shopt login_shell >/dev/null; then
  set -e -u
fi

if [ "${__IMOSH_IS_LOADED+loaded}" = 'loaded' ]; then
  return
fi
__IMOSH_IS_LOADED=loaded
