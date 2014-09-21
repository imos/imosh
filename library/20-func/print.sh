# Usage:
#   func::print(string message...) > output
#
# Print message to the standard output.  While "echo" consumes flags,
# func::print does not consume any flags, so this is theoretically safe.
func::print() {
  printf "%s" "$*"
}
