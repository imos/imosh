if sub::is_main; then
  if sub::isset 'IMOSH_TESTING' && (( IMOSH_TESTING )); then
    imosh::test_files "$@"
  fi
fi

__IMOSH_IS_LOADED=1
