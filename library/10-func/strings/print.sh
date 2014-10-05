# func::print -- Prints a message.
#
# Print message to the standard output.  While "echo" consumes flags,
# func::print does not consume any flags, so this is theoretically safe.
#
# Usage:
#   void func::print(string message...) > output
func::print() {
  printf "%s" "$*"
}
