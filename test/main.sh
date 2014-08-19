source "$(dirname "${BASH_SOURCE}")"/../imosh || exit 1
eval "${IMOSH_INIT}"

EXPECT_EQ() {
  local expected="$1"
  local actual="$2"

  if [ "$#" != 2 ]; then
    LOG FATAL "exactly two arguments must be given."
  fi
  if [ "${expected}" == "${actual}" ]; then return; fi
  echo "${BASH_SOURCE[1]}:${BASH_LINENO[0]}: Failure" >&2
  echo "  Actual: ${actual}" >&2
  echo "Expected: ${expected}" >&2
  IMOSH_TEST_IS_FAILED=1
}

ASSERT_EQ() {
  EXPECT_EQ "$@"
  if (( IMOSH_TEST_IS_FAILED )); then exit 1; fi
}

testing::run() {
  local test_name="$1"

  IMOSH_TEST_IS_FAILED=0
  test::"${test_name}"
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
}

IMOSH_TEST_IS_FAILED=0
if [ "$#" -gt '1' ]; then
  ppid=()
  i=0
  for file in "$@"; do
    format_i="$(printf '%05d' "${i}")"
    bash test/main.sh "${file}" \
        >"${IMOSH_TMPDIR}/test_index_${format_i}.stdout" \
        2>"${IMOSH_TMPDIR}/test_index_${format_i}.stderr" &
    ppid+=("$!")
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

echo "${IMOSH_COLOR_GREEN}[==========]${IMOSH_STYLE_DEFAULT}" \
     "Running tests for ${1}." >&2
source "$1" || exit 1
( ( declare -F | grep 'test::' ) || true ) >"${IMOSH_TMPDIR}/test_func"
if [ "$(cat "${IMOSH_TMPDIR}/test_func")" == '' ]; then
  LOG FATAL "$1 has no test."
fi
exec 3>&2
while read line; do
  function="${line##*test::}"
  echo "${IMOSH_COLOR_GREEN}[ RUN      ]${IMOSH_STYLE_DEFAULT} ${function}" >&2
  { time -p {
    export TMPDIR="${IMOSH_TMPDIR}"
    testing::run "${function}" 2>&3 &
    wait $!
  } } 2>"${IMOSH_TMPDIR}/time" &
  if wait $!; then
    time="($(echo $(cat "${IMOSH_TMPDIR}/time")))"
    echo "${IMOSH_COLOR_GREEN}[       OK ]${IMOSH_STYLE_DEFAULT}" \
         "${function} ${time}" >&2
  else
    time="($(echo $(cat "${IMOSH_TMPDIR}/time")))"
    echo "${IMOSH_COLOR_RED}[  FAILED  ]${IMOSH_STYLE_DEFAULT}" \
         "${function} ${time}" >&2
    IMOSH_TEST_IS_FAILED=1
  fi
done <"${IMOSH_TMPDIR}/test_func"
if (( IMOSH_TEST_IS_FAILED )); then
  exit 1
fi
