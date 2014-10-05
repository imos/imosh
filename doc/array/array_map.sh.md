# array_map
array_map -- Applies a callback to elements.

array_map applies a callback to every element.  stream::array_map applies a
callback to every line's elements.
stream::array_map supports the following functions: array, function, inplace
and command.

## Usage
```sh
void stream::array_map(
    string type, string callback [, string arguments...])
    < input > output
```


## Type
* --array
    * Reads every line as an array, and applies a callback to every line.
* --function
    * Reads every line as a string and applies a callback.  A callback should be
      a function format like: function(string* output, input).
* --inplace
    * Reads every line as a string and applies a callback.  A callback should be
      an inplace format like: function(string* input_and_output).
* --command
    * Reads every line as a string and applies a callback.  A callback should be
      a command format like: function(string input) > output.
