__IMOSH_IS_LOADED=1

if sub::is_main; then
  if sub::isset 'IMOSH_TESTING' && (( IMOSH_TESTING )); then
    eval "${IMOSH_INIT}"
    imosh::test_files "$@"
  fi
fi
