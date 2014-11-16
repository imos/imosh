# floatval
floatval -- Casts a variable as a float value.

Casts variable into float type.  If it fails, returns 1.

## Usage
```sh
// 1-a. Function form.
bool func::floatval(string* output, string input)
// 1-b. Inplace function form.
bool func::floatval(string* variable)
// 2. Command form.
bool sub::floatval(string input) > output
```
