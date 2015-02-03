__IMOSH_IS_LOADED=1

if sub::is_main; then
  eval "${IMOSH_INIT}"
  imosh::test_files "$@"
fi
