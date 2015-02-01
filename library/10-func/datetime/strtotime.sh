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
    if [ "${#2}" -eq 10 ]; then
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
