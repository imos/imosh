# test_file -- Tests a file.
#
# test_file tests test cases in a file.
#
# Usage:
#     void imosh::test_file(string file_path)
imosh::test_case() {
  if [ "$#" -eq 1 ]; then
    IMOSH_TEST_IS_FAILED=0
    "test::${1}"
    (( ! IMOSH_TEST_IS_FAILED )) || exit 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

imosh::test_file() {
  if [ "$#" -eq 1 ]; then
    sub::print   "${IMOSH_COLOR_GREEN}[==========]" >&2
    sub::println "${IMOSH_STYLE_DEFAULT} Running tests for ${1}." >&2
    IMOSH_TESTING=0 source "${1}" || exit 1
    ( ( declare -F | grep 'test::' ) || true ) >"${IMOSH_TMPDIR}/test_func"
    if [ "$(cat "${IMOSH_TMPDIR}/test_func")" == '' ]; then
      LOG FATAL "${1} has no test."
    fi
    exec 3>&2
    while read line; do
      function="${line##*test::}"
      sub::print   "${IMOSH_COLOR_GREEN}[ RUN      ]" >&2
      sub::println "${IMOSH_STYLE_DEFAULT} ${function}" >&2
      {
        time -p {
          imosh::test_case "${function}" 2>&1 &
          wait $!
        }
      } 2>"${IMOSH_TMPDIR}/time" \
        1>"${IMOSH_TMPDIR}/stdout" &
      if wait $!; then
        func::file_get_contents time "${IMOSH_TMPDIR}/time"
        func::greg_replace time '+([[:space:]])' ' '
        func::trim time
        sub::print   "${IMOSH_COLOR_GREEN}[       OK ]" >&2
        sub::println "${IMOSH_STYLE_DEFAULT} ${function} (${time})" >&2
      else
        cat "${IMOSH_TMPDIR}/stdout"
        func::file_get_contents time "${IMOSH_TMPDIR}/time"
        func::greg_replace time '+([[:space:]])' ' '
        func::trim time
        sub::print   "${IMOSH_COLOR_RED}[  FAILED  ]" >&2
        sub::println "${IMOSH_STYLE_DEFAULT} ${function} (${time})" >&2
        IMOSH_TEST_IS_FAILED=1
      fi
    done <"${IMOSH_TMPDIR}/test_func"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

imosh::test_files() {
  local IMOSH_TEST_IS_FAILED=0
  if [ "$#" -eq 1 ]; then
    imosh::test_file "${1}"
  else
    local ppid=()
    local files=()
    local file=''
    local index=0
    for file in "$@"; do
      sub::throttle 4
      "${BASH}" "${BASH_SOURCE}" "${file}" \
          >"${IMOSH_TMPDIR}/test_index_${index}.stdout" \
          2>"${IMOSH_TMPDIR}/test_index_${index}.stderr" &
      ppid+=("$!")
      files+=("${file}")
      (( index += 1 ))
    done
    index=0
    while [ "${index}" -lt "${#ppid[*]}" ]; do
      if ! wait "${ppid[${index}]}"; then
        IMOSH_TEST_IS_FAILED=1
        LOG ERROR "${files[${index}]} failed."
      fi
      cat "${IMOSH_TMPDIR}/test_index_${index}.stdout"
      cat "${IMOSH_TMPDIR}/test_index_${index}.stderr" >&2
      sub::println
      (( index += 1 ))
    done
  fi
  if (( IMOSH_TEST_IS_FAILED )); then
    exit 1
  fi
}
