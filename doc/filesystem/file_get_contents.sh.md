# file_get_contents
file_get_contents -- Reads an entire file into a string.

The function form reads an entire file and sets its contents to the
variable.  The subroutine form reads an entire file and outputs its contents
to the standard output.  The stream form reads a file name for each line and
outputs its contents to the standard output.

## Usage
```sh
// 1. Function form.
func::file_get_contents(string* variable, string filename)
// 2. Subroutine form.
sub::file_get_contents(string filename) > output
// 3. Stream form.
stream::file_get_contents() < input > output
```


## Examples
```sh
sub::print hello > "${TMPDIR}/foo"
func::file_get_contents variable "${TMPDIR}/foo"
echo "${variable}"  # => hello
```


```sh
sub::print hello > "${TMPDIR}/foo"
sub::file_get_contents "${TMPDIR}/foo"  # => hello
```


```sh
sub::print hello > "${TMPDIR}/foo"
sub::print world > "${TMPDIR}/bar"
{ echo "${TMPDIR}/foo"; echo "${TMPDIR}/bar"; } | \
    stream::file_get_contents  # => helloworld
```
