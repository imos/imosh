source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1
eval "${IMOSH_INIT}"

IMOSH_TEST_IS_FAILED=0
if [ "$#" -gt '1' ]; then
  ppid=()
  files=()
  i=0
  for file in "$@"; do
    format_i="$(printf '%05d' "${i}")"
    sub::throttle 4
    "${BASH}" test/main.sh "${file}" \
        >"${IMOSH_TMPDIR}/test_index_${format_i}.stdout" \
        2>"${IMOSH_TMPDIR}/test_index_${format_i}.stderr" &
    ppid+=("$!")
    files+=("${file}")
    (( i += 1 )) || true
  done
  max_i="${i}"
  i=0
  while (( i < max_i )); do
    format_i="$(printf '%05d' "${i}")"
    pid="${ppid[${i}]}"
    test_is_failed=0
    if ! wait "${pid}"; then
      test_is_failed=1
      IMOSH_TEST_IS_FAILED=1
      LOG ERROR "${files[${i}]} failed."
    fi
    cat "${IMOSH_TMPDIR}/test_index_${format_i}.stdout"
    cat "${IMOSH_TMPDIR}/test_index_${format_i}.stderr" >&2
    echo
    (( i += 1 )) || true
  done
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
  exit
fi

imosh::test_file "${1}"
