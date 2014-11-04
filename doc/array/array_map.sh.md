# array_map
array_map -- Applies a callback to elements.

array_map applies a callback to every element.  stream::array_map applies a
callback to every line's elements.
stream::array_map supports the following functions: array, function, inplace
and command.

## Usage
```sh
// 1. Function form.
void func::array_map(string[]* variable, string type,
                     string callback [, string arguments...])
// 2. Stream form.
void stream::array_map(
    string type, string callback [, string arguments...])
    < input > output
```


## Type
* ARRAY
    * Reads every line as an array, and applies a callback to every line.
* FUNCTION
    * Reads every line as a string and applies a callback.  A callback should be
      a function format like: function(string* output, input).
* INPLACE
    * Reads every line as a string and applies a callback.  A callback should be
      an inplace format like: function(string* input_and_output).
* COMMAND
    * Reads every line as a string and applies a callback.  A callback should be
      a command format like: function(string input) > output.

## Examples
```sh
input=('abc' 'DeF' '012')
func::array_map input INPLACE func::strtoupper
echo "${input[@]}" # => ABC DEF 012
```


```sh
sub::print $'def,abc,ghi\n1,3,2,5,4' | \
    IFS=',' stream::array_map ARRAY func::sort
    # => abc,def,ghi\n1,2,3,4,5
```


```sh
sub::print $'abcbd\nbcdbcb' | \
    stream::array_map INPLACE func::str_replace 'bc' 'BC'
    # => aBCbd\nBCdBCb
```
