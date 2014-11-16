# intval
intval -- Casts a variable as an integer value.

Casts variable into integer type.  If it fails, returns 1.

## Usage
```sh
// 1-a. Function from.
bool func::intval(string* output, string input)
// 1-b. Inplace function form.
bool func::intval(string* variable)
// 2. Command form.
bool sub::intval(string input) > output
```
