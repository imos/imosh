# array_unique
array_unique -- Removes duplicated elements from an array variable.

array_unique sorts elements first and removes duplicated elements.  Function
form applies array_unique to the given variable.  Stream form applies
array_unique to every line.  Every line is treated as elements.

## Usage
```sh
// 1. Function form.
void func::array_unique(string[]* variable)
// 2. Stream form.
void stream::array_unique() < input > output
```


## Examples
```sh
a=(c b a b)
func::array_unique a
echo "${a[@]}"  # => a b c
```


```sh
echo c b a b | stream::array_unique  # => a b c
```


```sh
echo c,b,a,b | IFS=, stream::array_unique  # => a,b,c
```
