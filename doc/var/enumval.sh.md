# enumval
enumval -- Casts a variable as an enum value.

Casts variable into enum type.  If it fails, returns 1.

## Usage
```sh
// 1-a. Function from.
bool func::enumval(string* output, string input)
// 1-b. Inplace function form.
bool func::enumval(string* variable)
// 2. Command form.
bool sub::enumval(string input) > output
```
