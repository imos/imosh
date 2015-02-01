# strtotime -- Parses a datetime text into a UNIX timestamp.
#
# strtotime parses a datetime text into a UNIX timestamp.
#
# Usage:
#     void func::strtotime(int* time, string time_text)
func::strtotime() {
  if [ "$#" -eq 2 ]; then
    local __func_strtotime_match=()
    local __func_strtotime_text=''
    if [ "${#2}" -eq 8 ]; then
      # 20060102
      if sub::ereg_match '^([0-9]{8})$' "${2}"; then
        __func::strtotime "${1}" "${2}000000" '%Y%m%d%H%M%S'
        return
      fi
    elif [ "${#2}" -eq 10 ]; then
      # 2006-01-02
      if sub::ereg_match '^([0-9]{4})[-/:]([0-9]{2})[-/:]([0-9]{2})$' \
          "${2}" __func_strtotime_match; then
        __func_strtotime_text+="${__func_strtotime_match[1]}"
        __func_strtotime_text+="-${__func_strtotime_match[2]}"
        __func_strtotime_text+="-${__func_strtotime_match[3]}"
        __func_strtotime_text+=' 00:00:00'
        __func::strtotime "${1}" "${__func_strtotime_text}" '%Y-%m-%d %H:%M:%S'
        return
      fi
    elif [ "${#2}" -eq 14 ]; then
      # 20060102150405
      if sub::ereg_match '^[0-9]{14}$' "${2}"; then
        __func::strtotime "${1}" "${2}" '%Y%m%d%H%M%S'
        return
      fi
    elif [ "${#2}" -eq 19 ]; then
      # 2006-01-02 15:04:05 (MySQL)
      # 2006/01/02 15:04:05 (Regular format)
      # 2006:01:02 15:04:05 (EXIF)
      # 2006-01-02T15:04:05
      if sub::ereg_match \
          '^([0-9]{4})[-/:]([0-9]{2})[-/:]([0-9]{2})[ T]([0-9]{2})[:\-]([0-9]{2})[:\-]([0-9]{2})$' \
          "${2}" __func_strtotime_match; then
        __func_strtotime_text+="${__func_strtotime_match[1]}"
        __func_strtotime_text+="-${__func_strtotime_match[2]}"
        __func_strtotime_text+="-${__func_strtotime_match[3]}"
        __func_strtotime_text+=" ${__func_strtotime_match[4]}"
        __func_strtotime_text+=":${__func_strtotime_match[5]}"
        __func_strtotime_text+=":${__func_strtotime_match[6]}"
        __func::strtotime "${1}" "${__func_strtotime_text}" '%Y-%m-%d %H:%M:%S'
        return
      fi
    fi
    # Mon, 02 Jan 2006 15:04:05 GMT (HTTP format)
    if sub::ereg_match \
        '^([A-Z][a-z]+, +)?([0-9]+)[/ \-]+([A-Z][a-z][a-z])[/ \-]+([0-9]{2}|[0-9]{4})[ :T]([0-9]{2})[:\-]([0-9]{2})[:\-]([0-9]{2}) *([A-Z][A-Za-z0-9\-\+ /]+)?([\-\+][0-9]{4})?$' \
        "${2}" __func_strtotime_match; then
      local __func_strtotime_timezone=''
      if [ "${__func_strtotime_match[8]}" != '' ]; then
        __func_strtotime_timezone="${__func_strtotime_match[8]}"
      elif [ "${__func_strtotime_match[9]}" != '' ]; then
        __func_strtotime_timezone="${__func_strtotime_match[9]}"
      fi
      case "${__func_strtotime_timezone}" in
        'JST') __func_strtotime_timezone='+0900';;
      esac
      if [ "${#__func_strtotime_match[4]}" -eq 2 ]; then
        if [ "${__func_strtotime_match[4]}" -lt 70 ]; then
          __func_strtotime_match[4]="20${__func_strtotime_match[4]}"
        else
          __func_strtotime_match[4]="19${__func_strtotime_match[4]}"
        fi
      fi
      func::exec __func_strtotime_text printf '%02d %s %04d %02d:%02d:%02d' \
          "${__func_strtotime_match[2]}" \
          "${__func_strtotime_match[3]}" \
          "${__func_strtotime_match[4]}" \
          "${__func_strtotime_match[5]}" \
          "${__func_strtotime_match[6]}" \
          "${__func_strtotime_match[7]}"
      if [ "${__func_strtotime_timezone}" != '' ]; then
        if sub::ereg_match '^[\-\+][0-9]{4}$' \
                           "${__func_strtotime_timezone}"; then
          __func::strtotime \
              "${1}" "${__func_strtotime_text} ${__func_strtotime_timezone}" \
              '%d %b %Y %H:%M:%S %z'
        else
          TZ="${__func_strtotime_timezone}" \
              __func::strtotime \
              "${1}" "${__func_strtotime_text}" '%d %b %Y %H:%M:%S'
        fi
      else
        __func::strtotime \
            "${1}" "${__func_strtotime_text}" '%d %b %Y %H:%M:%S'
      fi
      return
    fi
    # 02/Jan/2006 (Common logfile format)
    if sub::ereg_match \
        '^([0-9]+)[/ \-]+([A-Z][a-z][a-z])[/ \-]+([0-9]{4})$' \
        "${2}" __func_strtotime_match; then
      func::exec __func_strtotime_text printf '%02d %s %04d 00:00:00' \
          "${__func_strtotime_match[1]}" \
          "${__func_strtotime_match[2]}" \
          "${__func_strtotime_match[3]}"
      __func::strtotime "${1}" "${__func_strtotime_text}" '%d %b %Y %H:%M:%S'
      return
    fi
    # 02-Jan-06 (Old RFC850 HTTP format)
    if sub::ereg_match \
        '^([0-9]+)[/ \-]+([A-Z][a-z][a-z])[/ \-]+([0-9]{2})$' \
        "${2}" __func_strtotime_match; then
      func::exec __func_strtotime_text printf '%02d %s %02d 00:00:00' \
          "${__func_strtotime_match[1]}" \
          "${__func_strtotime_match[2]}" \
          "${__func_strtotime_match[3]}"
      __func::strtotime "${1}" "${__func_strtotime_text}" '%d %b %y %H:%M:%S'
      return
    fi
    # Jan 2 2006 (Unix ls format)
    if sub::ereg_match \
        '^([A-Z][a-z][a-z])[/ \-]+([0-9]+)[,/ \-]+([0-9]{4})$' \
        "${2}" __func_strtotime_match; then
      func::exec __func_strtotime_text printf '%02d %s %04d 00:00:00' \
          "${__func_strtotime_match[2]}" \
          "${__func_strtotime_match[1]}" \
          "${__func_strtotime_match[3]}"
      __func::strtotime "${1}" "${__func_strtotime_text}" '%d %b %Y %H:%M:%S'
      return
    fi
    # @1136214245 (Unix timestamp)
    if sub::ereg_match '^@?(-?[0-9]+)$' "${2}" __func_strtotime_match; then
      __func::strtotime "${1}" "${__func_strtotime_match[1]}" '%s'
      return
    fi
    LOG ERROR "Unkown date format: ${2}"
    return 1
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

sub::strtotime() {
  if [ "$#" -eq 1 ]; then
    local __sub_strtotime=''
    func::strtotime __sub_strtotime "${1}"
    sub::println "${__sub_strtotime}"
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}

# void __func::strtotime(int* time, string input_time, string input_format)
__func::strtotime() {
  if [ "$#" -eq 3 ]; then
    if [ "${UNAME}" = 'Linux' ]; then
      func::let "${1}" "$(LC_ALL=C date --date="${2}" '+%s')"
    else
      func::let "${1}" "$(LC_ALL=C date -j -f "${3}" "${2}" '+%s')"
    fi
  else
    eval "${IMOSH_WRONG_NUMBER_OF_ARGUMENTS}"
  fi
}
