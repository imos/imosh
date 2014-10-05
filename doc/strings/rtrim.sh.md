# func::rtrim
func::rtrim -- Strips whitespace(s) from the end of a string.

Strips whitespace (or other characters) from the end of a string.

## Usage
```sh
// 1. Function form.
void func::rtrim(string* output, string input)
// 2. Inplace form.
void func::rtrim(string* variable)
// 3. Command form.
void sub::rtrim(string value) > output
// 4. Stream form.
void stream::rtrim() < input > output
```
