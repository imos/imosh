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
# --format=text
#   Select one fromat from text/markdown/groff.
# --title=true
#   Treat the first line as title.
__imosh::show_usage() {
  local ARGS_format=text ARGS_title=1
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
      if [ "${ARGS_format}" = 'text' ]; then
        echo "${line}"
        continue
      fi
      func::rtrim line
      if (( first_line )); then
        case "${ARGS_format}" in
          groff)    echo ".TH ${line} 1";;
          markdown) echo "## ${line}";;
        esac
        first_line=0
        continue
      fi
      while func::greg_match '*:' "${line}"; do
        if [ "${line%:}" = 'Usage' ]; then
          case "${ARGS_format}" in
            groff)    echo '.SH USAGE'
                      echo '.Bd -literal -offset indent';;
            markdown) echo '```cpp';;
          esac
        else
          local title="${line%:}"
          func::strtoupper title
          case "${ARGS_format}" in
            groff)
                echo ".SH ${title}"
                echo '.Bd -literal -offset indent';;
            markdown)
                echo 
                echo "### ${line%:}"
                echo
                echo '```sh';;
          esac
        fi
        while IFS= read -r line; do
          if [ "${line:0:4}" != '    ' ]; then
            break
          fi
          case "${ARGS_format}" in
            groff)    echo "${line#'    '}";;
            markdown) echo "${line#'    '}";;
          esac
        done
        case "${ARGS_format}" in
          groff)    echo '.Ed';;
          markdown) echo '```'
                    echo;;
        esac
      done
      if func::greg_match '*( )-*' "${line}"; then
        func::ltrim line
        if [ "${line:0:2}" = '- ' ]; then
          line="${line:2}"
        fi
        case "${ARGS_format}" in
          groff)    echo '.TP'
                    echo ".B ${line}";;
          markdown) echo "* ${line}";;
        esac
        while IFS= read -r line; do
          if func::greg_match '*( )-*' "${line}" || \
             func::greg_match '*([[:space:]])' "${line}"; then
            break
          fi
          func::ltrim line
          case "${ARGS_format}" in
            groff)    echo "${line}";;
            markdown) echo "    ${line}";;
          esac
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
