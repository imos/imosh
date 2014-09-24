# func::strcpy -- Copies a string from a variable to another variable.
#
# Usage:
#   void func::strcpy(string* destination, string *source)
#
# Assigns the content of a variable specified as source into destination.
func::strcpy() {
  local __strcpy_destination="$1"
  local __strcpy_source="$2"

  eval "${__strcpy_destination}=\"\${${__strcpy_source}}\""
}
