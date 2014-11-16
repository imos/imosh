# str_replace
str_replace -- Replaces a substring with another substring.

Replace search with replace in *subject.

## Usage
```sh
// 1. Function form.
void func::str_replace(string* subject, string search, string replace)
// 2. Command form.
void sub::str_replace(
    string input, string search, string replace) > output
// 3. Stream form.
void stream::str_replace(string search, string replace) < input > output
```
