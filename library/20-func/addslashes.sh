# Usage:
#   void func::addslashes(string* subject)
#
# Quotes string with backslashes. Single quote, double quote and backslash in
# subject are escaped.
func::addslashes() {
  func::str_replace "${1}" '\' '\\'
  func::str_replace "${1}" "'" "\\'"
  func::str_replace "${1}" '"' '\"'
}
