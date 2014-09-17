# Usage:
#   func::let destination value
#
# Assigns value into destination.
func::let() {
  local __let_destination="$1"
  local __let_value="$2"

  eval "${__let_destination}=\"\${__let_value}\""
}
