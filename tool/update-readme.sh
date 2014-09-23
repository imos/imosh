cd "$(dirname "${BASH_SOURCE}")"/..

source ./imosh || exit 1
eval "${IMOSH_INIT}"

show_introduction() {
  local line=''
  while IFS= read -r line; do
    echo "${line}"
    if [ "${line}" = '<!-- MARKER:AUTO_GENERATED -->' ]; then
      break
    fi
  done <'README.md'
  echo
}

get_usage() {
  local file="$1"
  local line=''
  while IFS= read -r line; do
    case "${line}" in
      '#!'*) continue;;
      '# '*) echo "${line:2}";;
      '#'*)  echo "${line:1}";;
      *)     break;;
    esac
  done <"${file}"
}

show_usage() {
  local usage="$(get_usage "$1")"
  if [ "${usage}" = '' ]; then
    return
  fi

  local line='' first_line=1
  while IFS= read -r line; do
    func::rtrim line
    if (( first_line )); then
      echo "## ${line}"
      first_line=0
      continue
    fi
    while func::greg_match '*:' "${line}"; do
      if [ "${line%:}" = 'Usage' ]; then
        echo '```cpp'
      else
        echo "### ${line%:}"
        echo
        echo '```sh'
      fi
      while IFS= read -r line; do
        if [ "${line:0:2}" != '  ' ]; then
          break
        fi
        echo "${line#'  '}"
      done
      echo '```'
      echo
    done
    echo "${line}"
  done <<<"${usage}"
  echo
}

show_readme() {
  show_introduction
  echo '# Functions'
  echo
  for file in library/*-func/*.sh; do
    show_usage "${file}"
  done
}

show_readme >"${TMPDIR}/README.md"
cat "${TMPDIR}/README.md" > 'README.md'
