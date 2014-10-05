# sort
sort -- Sorts elements.

sort sorts elements.  The function form sorts elements in a variable in place.
The stream form applies sort to every line.  Every line is treated as
elements.

## Usage
```sh
// 1. Function form.
void func::sort(string[]* variable)
// 2. Stream form.
void stream::sort() < input > output
```
