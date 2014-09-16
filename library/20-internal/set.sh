# Usage:
#   imosh::internal::set destination source
#
# Sets the content of a variable specfied in source into destination.
imosh::internal::set() {
  local __set_destination="$1"
  local __set_source="$2"

  eval "${__set_destination}=\"\${${__set_source}}\""
}
