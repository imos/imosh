source imosh || exit 1
source "$1" || exit 1

set -e -u

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

testing::run() {
  local test_name="$1"

  IMOSH_TEST_IS_FAILED=0
  test::"${test_name}"
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
}

( ( declare -F | grep 'test::' ) || true ) >"${TMPDIR}/test_func"
if [ "$(cat "${TMPDIR}/test_func")" == '' ]; then
  LOG FATAL "$1 has no test."
fi
exec 3>&2
while read line; do
  function="${line##*test::}"
  echo "${IMOSH_COLOR_GREEN}[ RUN      ]${IMOSH_COLOR_DEFAULT} ${function}" >&2
  { time -p {
    testing::run "${function}" 2>&3 &
    wait $!
  } } 2>"${TMPDIR}/time" &
  wait $!
  status="$?"
  time="($(echo $(cat "${TMPDIR}/time")))"
  if (( status == 0 )); then
    echo "${IMOSH_COLOR_GREEN}[       OK ]${IMOSH_COLOR_DEFAULT}" \
         "${function} ${time}" >&2
  else
    echo "${IMOSH_COLOR_RED}[  FAILED  ]${IMOSH_COLOR_DEFAULT}" \
         "${function} ${time}" >&2
  fi
done <"${TMPDIR}/test_func"
