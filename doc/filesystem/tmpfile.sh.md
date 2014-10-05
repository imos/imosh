# func::tmpfile
func::tmpfile -- Creates a temporary file.

Creates a temporary file with a unique name under ${TMPDIR}.

## Usage
```sh
// 1. Function form.
void func::tmpfile(string* path)
// 2. Command form.
void sub::tmpfile() > path
```
