# func::array_unique, stream::array_unique
func::array_unique, stream::array_unique -- Removes duplicated elements from an array variable.

func::array_unique sorts elements first and removes duplicated elements.
stream::array_unique reads a line and applies it with func::array_unique.
stream::array_unique splits a line with IFS and joins elements with IFS's
first character.

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
