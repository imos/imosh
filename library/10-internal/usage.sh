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
#     bool __imosh::show_usage(string file) > output
#
# Options:
#   --format=text
#     Select one fromat from text/markdown/groff.
#   --title=true
#     Treat the first line as title.
#   --markdown_heading=''
#     Prepend a string to every heading.
__imosh::show_usage() {
  local ARGS_format=text ARGS_title=1 ARGS_markdown_heading=''
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -eq 1 ]; then
    local file="$1"

    local usage="$(__imosh::get_usage "$1")"
    [ "${usage}" != '' ] || return
    if [ "${ARGS_format}" = 'text' ]; then
      sub::print "${usage}"$'\n\n'
      return
    fi

    local line='' first_line="${ARGS_title}" no_read=0
    while :; do
      (( no_read )) || IFS= read -r line || break
      no_read=0
      func::rtrim line
      if (( first_line )); then
        case "${ARGS_format}" in
          groff)    echo ".TH ${line} 1";;
          markdown) echo "${ARGS_markdown_heading} ${line}";;
        esac
        first_line=0
        continue
      fi
      if sub::greg_match '*:' "${line}"; then
        local title="${line%:}"
        func::strtoupper title
        case "${ARGS_format}" in
          groff)    echo ".SH ${title}";;
          markdown) echo "${ARGS_markdown_heading}# ${line%:}";;
        esac
        continue
      fi

      local code_mode=0
      while [ "${line:0:4}" = '    ' ]; do
        if (( ! code_mode )); then
          case "${ARGS_format}" in
            groff)    echo '.Bd -literal -offset indent';;
            markdown) echo '```sh';;
          esac
          code_mode=1
        fi
        case "${ARGS_format}" in
          groff)    echo "${line#'    '}";;
          markdown) echo "${line#'    '}";;
        esac
        code_mode=1
        if ! IFS= read -r line; then break; fi
      done
      if (( code_mode )); then
        case "${ARGS_format}" in
          groff)    echo '.Ed';;
          markdown) echo '```'
                    echo;;
        esac
        no_read=1
        continue
      fi

      if sub::greg_match '*( )-*' "${line}"; then
        func::ltrim line
        if [ "${line:0:2}" = '- ' ]; then
          line="${line:2}"
        fi
        case "${ARGS_format}" in
          groff)    echo '.TP'
                    echo ".B ${line}";;
          markdown) echo "* ${line}";;
        esac
        local item_first_line=1
        while IFS= read -r line; do
          if sub::greg_match '*( )-*' "${line}" || \
             sub::greg_match '*([[:space:]])' "${line}"; then
            break
          fi
          func::ltrim line
          case "${ARGS_format}" in
            groff)    echo "${line}";;
            markdown)
              if (( item_first_line )); then
                echo "    * ${line}"
                item_first_line=0
              else
                echo "      ${line}"
              fi
              ;;
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
