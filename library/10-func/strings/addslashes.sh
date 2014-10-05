# func::addslashes -- Quotes a string with backslahses.
#
# Quotes string with backslashes. Single quote, double quote and backslash in
# subject are escaped.
#
# Usage:
#     void func::addslashes(string* subject)
func::addslashes() {
  func::str_replace "${1}" '\' '\\'
  func::str_replace "${1}" "'" "\\'"
  func::str_replace "${1}" '"' '\"'
}
