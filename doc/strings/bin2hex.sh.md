# func::bin2hex
func::bin2hex -- Converts a binary string into hexadecimal representation.

Converts binary data into hexadecimal representation.

## Usage
```sh
// 1. Function form.
void func::bin2hex(string* hexadecimal_output, string binary_input)
// 2. Command form.
void sub::bin2hex(string binary_input) > hexadecimal_output
// 3. Stream form.
void stream::bin2hex() < binary_input > hexadecimal_output
```
