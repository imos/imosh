# println
println -- Prints a message with a new line.

Print message to the standard output with a new line.  While "echo" consumes
flags, println does not consume any flags, so this is theoretically safe.

## Usage
```sh
// DEPRECATED.
void func::println(string message...) > output
// 1. Command form.
void sub::println(string message...) > output
```
