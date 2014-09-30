# func::tmpfile
func::tmpfile -- Creates a temporary file.

## Usage
  // 1. Function form.
  void func::tmpfile(string* path)
  // 2. Command form.
  void func::tmpfile() > path

Creates a temporary file with a unique name under TMPDIR.
