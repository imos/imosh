imosh::internal::style() {
  echo -en "\\033[${1}m"
}

IMOSH_COLOR_DEFAULT="$(imosh::internal::style '0;39')"
IMOSH_COLOR_BLACK="$(imosh::internal::style '0;30')"
IMOSH_COLOR_RED="$(imosh::internal::style '0;31')"
IMOSH_COLOR_GREEN="$(imosh::internal::style '0;32')"
IMOSH_COLOR_YELLOW="$(imosh::internal::style '0;33')"
IMOSH_COLOR_BLUE="$(imosh::internal::style '0;34')"
IMOSH_COLOR_MAGENTA="$(imosh::internal::style '0;35')"
IMOSH_COLOR_CYAN="$(imosh::internal::style '0;36')"
IMOSH_COLOR_WHITE="$(imosh::internal::style '0;37')"
