imosh::internal::convert_type() {
  local type="$1"; shift
  local value="$1"; shift

  case "${type}" in
    int)
      if [[ "${value}" =~ ^-?[0-9]+$ ]]; then
        print "${value}"
      else
        return 1
      fi
      ;;
    string)
      print "${value}"
      ;;
    bool)
      case "${value}" in
        1|T|t|[Tt]rue) print 1;;
        0|F|f|[Ff]alse) print 0;;
        *) return 1;;
      esac
      ;;
    variant)
      print "${value}"
      ;;
    *) LOG FATAL "no such type: ${type}";;
  esac
}
