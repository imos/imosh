# func::let -- Assigns a value into a variable.
#
# Assigns value into *destination.
#
# Usage:
#     func::let(string* destination, string value)
func::let() {
  local __let_destination="$1"
  local __let_value="$2"

  eval "${__let_destination}=\"\${__let_value}\""
}
