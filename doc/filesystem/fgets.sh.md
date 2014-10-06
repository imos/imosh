# fgets
fgets -- Gets a line from STDIN.

fgets reads a line and regards it as a result.  fgets does not strip a
trailing new line.  The function form sets the result to a variable.  The
subroutine form outputs the result to the standard output.

## Usage
```sh
// 1. Function form.
bool func::fgets(string* variable)
// 2. Subroutine form.
bool sub::fgets() > line
```
