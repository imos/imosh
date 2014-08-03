# imosh - Libraries for BASH.

set -e -u

if [ "${__IMOSH_IS_LOADED+loaded}" == 'loaded' ]; then
  return
fi
__IMOSH_IS_LOADED=loaded
