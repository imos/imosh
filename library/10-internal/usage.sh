# __imosh::get_usage
#
# Usage:
#   void __imosh::get_usage(string file) > output
__imosh::get_usage() {
  local file="$1"
  local line=''
  while IFS= read -r line; do
    case "${line}" in
      '#!'*) continue;;
      '# '*) echo "${line:2}";;
      '#'*)  echo "${line:1}";;
      *)     break;;
    esac
  done < "${file}"
}

# __imosh::show_usage
#
# Usage:
#   bool __imosh::show_usage(string file) > output
#
# Options:
# --groff=false
#   Enable groff mode.
# --title=true
#   Treat the first line as title.
__imosh::show_usage() {
  local ARGS_groff=0 ARGS_title=1
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -eq 1 ]; then
    local file="$1"

    local usage="$(__imosh::get_usage "$1")"
    if [ "${usage}" = '' ]; then
      return
    fi

    local line='' first_line="${ARGS_title}" no_read=0
    while :; do
      if (( ! no_read )) && ! IFS= read -r line; then
        break
      fi
      no_read=0
      func::rtrim line
      if (( first_line )); then
        if (( ARGS_groff )); then
          echo ".TH ${line} 1"
        else
          echo "## ${line}"
        fi
        first_line=0
        continue
      fi
      while func::greg_match '*:' "${line}"; do
        if [ "${line%:}" = 'Usage' ]; then
          if (( ARGS_groff )); then
            echo '.SH USAGE'
            echo '.Bd -literal -offset indent'
          else
            echo '```cpp'
          fi
        else
          if (( ARGS_groff )); then
            local title="${line%:}"
            func::strtoupper title
            echo ".SH ${title}"
            echo '.Bd -literal -offset indent'
          else
            echo 
            echo "### ${line%:}"
            echo
            echo '```sh'
          fi
        fi
        while IFS= read -r line; do
          if [ "${line:0:2}" != '  ' ]; then
            break
          fi
          echo "${line#'  '}"
        done
        if (( ARGS_groff )); then
          echo '.Ed'
        else
          echo '```'
          echo
        fi
      done
      if [ "${line:0:1}" = '-' ]; then
        if (( ARGS_groff )); then
          echo '.TP'
          echo ".B ${line:1}"
        else
          echo "* ${line:1}"
        fi
        while IFS= read -r line; do
          if [ "${line:0:1}" != ' ' ]; then
            break
          fi
          func::ltrim line
          if (( ARGS_groff )); then
            echo "${line}"
          else
            echo "    ${line}"
          fi
        done
        no_read=1
        continue
      fi
      echo "${line}"
    done <<<"${usage}"
    echo
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}
