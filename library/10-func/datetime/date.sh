# date -- Format a local time/date.
#
# date formats a local time/date.
#
# Usage:
#     void func::date(string* output, string format, int time)
func::date() {
  if [ "$#" -eq 3 ]; then
    local __func_date_php="${2}"
    local __func_date_c=''
    local __func_date_buffer=''
    while [ "${__func_date_php}" != '' ]; do
      case "${__func_date_php}" in
        'd'*)
          __func_date_c+='%d'
          __func_date_php="${__func_date_php:1}"
          ;;
        'D'*)
          __func_date_c+='%a'
          __func_date_php="${__func_date_php:1}"
          ;;
        'j'*)
          __func_date_c+='%-d'
          __func_date_php="${__func_date_php:1}"
          ;;
        'l'*)
          __func_date_c+='%A'
          __func_date_php="${__func_date_php:1}"
          ;;
        'N'*)
          __func_date_c+='%u'
          __func_date_php="${__func_date_php:1}"
          ;;
        'w'*)
          __func_date_c+='%w'
          __func_date_php="${__func_date_php:1}"
          ;;
        'z'*)
          __func_date_c+='%-j'
          __func_date_php="${__func_date_php:1}"
          ;;
        'W'*)
          __func_date_c+='%W'
          __func_date_php="${__func_date_php:1}"
          ;;
        'F'*)
          __func_date_c+='%B'
          __func_date_php="${__func_date_php:1}"
          ;;
        'm'*)
          __func_date_c+='%m'
          __func_date_php="${__func_date_php:1}"
          ;;
        'M'*)
          __func_date_c+='%b'
          __func_date_php="${__func_date_php:1}"
          ;;
        'n'*)
          __func_date_c+='%-m'
          __func_date_php="${__func_date_php:1}"
          ;;
        'o'*)
          __func_date_c+='%G'
          __func_date_php="${__func_date_php:1}"
          ;;
        'Y'*)
          __func_date_c+='%Y'
          __func_date_php="${__func_date_php:1}"
          ;;
        'y'*)
          __func_date_c+='%y'
          __func_date_php="${__func_date_php:1}"
          ;;
        'a'*)
          __func_date_c+='%P'
          __func_date_php="${__func_date_php:1}"
          ;;
        'A'*)
          __func_date_c+='%p'
          __func_date_php="${__func_date_php:1}"
          ;;
        'g'*)
          __func_date_c+='%-I'
          __func_date_php="${__func_date_php:1}"
          ;;
        'G'*)
          __func_date_c+='%-H'
          __func_date_php="${__func_date_php:1}"
          ;;
        'h'*)
          __func_date_c+='%I'
          __func_date_php="${__func_date_php:1}"
          ;;
        'H'*)
          __func_date_c+='%H'
          __func_date_php="${__func_date_php:1}"
          ;;
        'i'*)
          __func_date_c+='%M'
          __func_date_php="${__func_date_php:1}"
          ;;
        's'*)
          __func_date_c+='%S'
          __func_date_php="${__func_date_php:1}"
          ;;
        'e'*|'T'*)
          __func_date_c+='%Z'
          __func_date_php="${__func_date_php:1}"
          ;;
        'O'*)
          __func_date_c+='%z'
          __func_date_php="${__func_date_php:1}"
          ;;
        'P'*)
          __func::date __func_date_buffer '%z' "${3}"
          __func_date_c+="${__func_date_buffer:0:3}:${__func_date_buffer:3}"
          __func_date_php="${__func_date_php:1}"
          ;;
        'c'*)
          __func_date_c+='%Y-%m-%dT%H:%M:%S'
          __func::date __func_date_buffer '%z' "${3}"
          __func_date_c+="${__func_date_buffer:0:3}:${__func_date_buffer:3}"
          __func_date_php="${__func_date_php:1}"
          ;;
        'r'*)
          __func_date_c+='%a, %d %b %Y %T %z'
          __func_date_php="${__func_date_php:1}"
          ;;
        'U'*)
          __func_date_c+='%s'
          __func_date_php="${__func_date_php:1}"
          ;;
        '\%'*|'%'*)
          __func_date_c+='%%'
          __func_date_php="${__func_date_php:1}"
          ;;
        '\'*)
          __func_date_c+="${__func_date_php:0:2}"
          __func_date_php="${__func_date_php:2}"
          ;;
        *)
          __func_date_c+="${__func_date_php:0:1}"
          __func_date_php="${__func_date_php:1}"
          ;;
      esac
    done
    __func::date "${1}" "${__func_date_c}" "${3}"
  elif [ "$#" -eq 2 ]; then
    func::date "$@" "$(date +'%s')"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

__func::date() {
  if [ "$#" -eq 3 ]; then
    if [ "${UNAME}" = 'Linux' ]; then
      func::let "${1}" "$(LC_ALL=C date --date="@${3}" "+${2}")"
    else
      func::let "${1}" "$(LC_ALL=C date -j -f '@%s' "@${3}" "+${2}")"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
