# Color definitions.  A shell script should restore terminal's original color
# using IMOSH_STYLE_DEFAULT when it changes color or style.

readonly IMOSH_STYLE_DEFAULT=$'\033[0m'
readonly IMOSH_COLOR_DEFAULT=$'\033[0;39m'
readonly IMOSH_COLOR_BLACK=$'\033[0;30m'
readonly IMOSH_COLOR_RED=$'\033[0;31m'
readonly IMOSH_COLOR_GREEN=$'\033[0;32m'
readonly IMOSH_COLOR_YELLOW=$'\033[0;33m'
readonly IMOSH_COLOR_BLUE=$'\033[0;34m'
readonly IMOSH_COLOR_MAGENTA=$'\033[0;35m'
readonly IMOSH_COLOR_CYAN=$'\033[0;36m'
readonly IMOSH_COLOR_WHITE=$'\033[0;37m'
