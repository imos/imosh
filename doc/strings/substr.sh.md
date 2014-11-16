# substr
substr -- Returns a substring.

substr returns a substring of a string specfied by start and length.

## Usage
```sh
// 1. Function form.
void func::substr(
    string* output, string input, string start, string length)
void func::substr(
    string* output, string input, string start)
// 2. Command form.
void sub::substr(string input, string start, string length) > output
void sub::substr(string input, string start) > output
```
