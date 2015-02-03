# usage -- Shows a usage message.
#
# usage shows a usage message based on a header comment.  A header comment
# consists of consecutive comment lines.  Comment lines starting with "#!" are
# ignored.
#
# Usage:
#     void sub::usage(string file) > output
#
# Options:
# - --format=text
#       Select one fromat from text/markdown/groff.
# - --title=true
#       Treat the first line as title.
# - --markdown_heading=''
#       Prepend a string to every heading.
sub::usage() {
  local ARGS_format='text' ARGS_title=1 ARGS_markdown_heading=''
  eval "${IMOSH_PARSE_ARGUMENTS}"

  if [ "$#" -eq 1 ]; then
    local usage='' line='' first_line="${ARGS_title}" is_buffered=0
    while IFS= read -r line; do
      case "${line}" in
        '#!'*) continue;;
        '# '*) usage+="${line:2}"$'\n';;
        '#'*)  usage+="${line:1}"$'\n';;
        *)     break;;
      esac
    done < "${1}"
    func::trim usage
    [ "${usage}" != '' ] || return
    if [ "${ARGS_format}" = 'text' ]; then
      sub::print "${usage}"$'\n\n'
      return
    fi
    while :; do
      (( is_buffered )) || IFS= read -r line || break
      is_buffered=0
      func::rtrim line
      # Show title.
      if (( first_line )); then
        case "${ARGS_format}" in
          'groff')    sub::println ".TH ${line} 1";;
          'markdown') sub::println "${ARGS_markdown_heading} ${line}";;
        esac
        first_line=0
      # Show section title.
      elif sub::greg_match '*:' "${line}"; then
        local title="${line%:}"
        func::strtoupper title
        case "${ARGS_format}" in
          'groff')    sub::println ".SH ${title}";;
          'markdown') sub::println "${ARGS_markdown_heading}# ${line%:}";;
        esac
      # Show code.
      elif [ "${line:0:4}" = '    ' ]; then
        case "${ARGS_format}" in
          'groff')    sub::println '.Bd -literal -offset indent';;
          'markdown') sub::println '```sh';;
        esac
        while [ "${line:0:4}" = '    ' ]; do
          case "${ARGS_format}" in
            'groff')    sub::println "${line#'    '}";;
            'markdown') sub::println "${line#'    '}";;
          esac
          IFS= read -r line || break
        done
        case "${ARGS_format}" in
          'groff')    sub::println '.Ed';;
          'markdown') sub::print $'```\n\n';;
        esac
        is_buffered=1
      # Show an item.
      elif sub::greg_match '*( )- *' "${line}"; then
        func::ltrim line
        CHECK [ "${line:0:2}" = '- ' ]
        line="${line:2}"
        case "${ARGS_format}" in
          'groff')    sub::println $'.TP\n'".B ${line}";;
          'markdown') sub::println "* ${line}";;
        esac
        local markdown_indent='    * '
        while IFS= read -r line; do
          if sub::greg_match '*( )- *' "${line}" || \
             sub::greg_match '*([[:space:]])' "${line}"; then
            break
          fi
          func::ltrim line
          case "${ARGS_format}" in
            'groff')    sub::println "${line}";;
            'markdown') sub::println "${markdown_indent}${line}"
                        markdown_indent='      ';;
          esac
        done
        is_buffered=1
      else
        sub::println "${line}"
      fi
    done <<<"${usage}"
    sub::println
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
