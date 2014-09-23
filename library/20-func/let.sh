# func::let -- Assigns a value into a variable.
#
# Usage:
#   func::let(string* destination, string value)
#
# Assigns value into *destination.
func::let() {
  local __let_destination="$1"
  local __let_value="$2"

  eval "${__let_destination}=\"\${__let_value}\""
}
