# Return if imosh is reloaded.  Operations in 50+ run level may have
# destructive operations, so they are skipped in reloading.
if [ "${__IMOSH_IS_LOADED+loaded}" = 'loaded' ]; then
  return
fi
