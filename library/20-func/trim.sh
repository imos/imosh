# func::trim -- Strips whitespaces from both sides.
#
# Usage:
#   void func::trim(string* variable)
#
# Strips whitespace (or other characters) from the beginning and end of a
# string.
func::trim() {
  func::rtrim "$1"
  func::ltrim "$1"
}
