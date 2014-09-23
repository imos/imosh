Introduction
============

imosh is a library for bash.
It consists of utilities like gflags and glog and PHP-like functions.

imosh is tested on drone.io (https://drone.io/github.com/imos/imosh).

Supported BASH versions
-----------------------

* BASH 3.2.51 on Mac OSX Mavericks
* BASH 4.2.25 on Ubuntu 14.04


Features
========

Man-like help
-------------

imosh can show a help page like a man page.

![imosh help page](https://raw.github.com/wiki/imos/imosh/images/help.png)

Stack trace
-----------

imosh shows a stack trace when some error arises.

![imosh stack trace](https://raw.github.com/wiki/imos/imosh/images/stacktrace.png)

gflags-like flag definitions
----------------------------

imosh enables shell scripts to use flag definitions like gflags.

```sh
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'
```

Glog-like logging
-----------------

imosh provides a standard way for logging like glog.

```sh
LOG ERROR 'some error happens!'
```

Usage
=====

Copy imosh in the top directory to some directory listed in `${PATH}`.

```sh
source imosh || exit 1

DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"
```

Terminal
--------

imosh is also useful for regular shell operations.
You can use imosh by running the following command beforehand:

```sh
source imosh
```


Flag Definition
===============

```sh
DEFINE_<type> <flag name> <default value> <flag description>
```

Flag Types
----------

* string ... string type,
* bool ... boolean type,
* int ... integer type.

Flag Options
------------

* --alias=`alias name` ... declares a flag alias.  This is useful for short flag names.

Other Features
--------------

* The --help (-h) flag is defined, and it shows the list of flags defined in the script.
* Environment variables specified by `IMOSH_FLAGS_<flag name>` change flags' default values.


Logging
=======

```sh
LOG <severity> <message>
```

Severity
--------

* `INFO` is NOT output to stderr by default,
* `WARNING` is NOT output to stderr by default,
* `ERROR` is output to stderr by default,
* `FATAL` is output to stderr by default.

Flags
-----

* `--alsologtostderr` makes all severities output to stderr in addition to log files,
* `--logtostderr` makes all severities output to stderr instead of log files.

Path to Output
--------------

imosh outputs log files to `${TMPDIR}/<program name>.<host name>.<user>.<severity>.<date>.<time>.<process ID>`.

<!-- MARKER:AUTO_GENERATED -->

# Functions

## func::addslashes -- Quotes a string with backslahses.

```cpp
void func::addslashes(string* subject)
```


Quotes string with backslashes. Single quote, double quote and backslash in
subject are escaped.

## func::array_unique -- Remove duplicated elements from an array variable.

```cpp
void func::array_unique(string[]* variable)
```



## func::bin2hex -- Converts a binary string into hexadecimal representation.

```cpp
void func::bin2hex(string* hexadecimal_output, string binary_input)
void func::bin2hex(string binary_input) > hexadecimal_output
void func::bin2hex() < binary_input > hexadecimal_output
```


Converts binary data into hexadecimal representation.

## func::escapeshellarg - Escapes a variable as a shell argument.

```cpp
void func::escapeshellarg(string* variable)
```


Escapes variable's content.

## func::explode -- Splits a string by a substring.

```cpp
void func::explode(string* variable, string delimiter, string value)
```


Splits a string by string.

## func::floatval -- Casts a variable as a float value.

```cpp
bool func::floatval(string* variable)
```


Casts variable into float type.  If it fails, returns 1.

## func::getchildpids -- Gets child process IDs.

```cpp
func::getchildpids(int[]* variable)
```



## func::getmypid -- Gets the current process ID.

```cpp
func::pid(int* variable)
```



## func::greg_match -- Checks if a string matches a GREG pattern.

```cpp
void func::greg_match(string pattern, string subject)
```


Replace pattern with replace in *subject.

## func::greg_replace -- Replace a GREG pattern with a string.

```cpp
void func::greg_replace(string* subject, string pattern, string replace)
```


Replace pattern with replace in *subject.

## func::hex2bin -- Decodes a hexadecimally encoded binary string.

```cpp
void func::hex2bin(string* output, string input)
void func::hex2bin(string* variable)
void func::hex2bin() < input > output
```


Decodes a hexadecimally encoded binary string.

## func::implode -- Joins array elements with a string.

```cpp
// 1. Function form.
void func::implode(string* variable, string glue, string[]* pieces)
// 2. Command form.
void func::implode(string glue, string[]* pieces) > result
// 3. Stream form.
void func::implode(string glue) < input > output
```


### Alias

```sh
func::join is an alias of func::implode.
```


func::implode joins `pieces` with `glue`.
**Stream form** uses IFS as an input separator and processes line by line.

## func::intval -- Casts a variable as an integer value.

```cpp
bool func::intval(string* variable)
```


Casts variable into integer type.  If it fails, returns 1.

## func::isset -- Checks if a variable exists.

```cpp
bool func::isset(variant* variable)
```


Returns true iff variable exists.

CAVEATS: func::isset returns true for uninitialized variables in BASH 3, and
         returns false for them in BASH 4.

## func::let -- Assigns a value into a variable.

```cpp
func::let(string* destination, string value)
```


Assigns value into *destination.

## func::ltrim -- Strips whitespace(s) from the beginning of a string.

```cpp
void func::ltrim(string* variable)
```


Strips whitespace (or other characters) from the beginning of a string.

## func::md5 -- Calculates a MD5 hash.

```cpp
void func::md5() < input > hash
void func::md5(string data) > hash
void func::md5(string* variable, string data)
```



## func::ord -- Gets a character's ASCII code.

```cpp
func::ord(string* variable, string character)
```


Sets ASCII value of character to variable.

## func::print -- Prints a message.

```cpp
void func::print(string message...) > output
```


Print message to the standard output.  While "echo" consumes flags,
func::print does not consume any flags, so this is theoretically safe.

## func::println -- Prints a message with a new line.

```cpp
void func::println(string message...) > output
```


Print message to the standard output with a new line.  While "echo" consumes
flags, func::println does not consume any flags, so this is theoretically
safe.

## func::rand -- Generates a random integer.

```cpp
void func::rand(int* variable)
void func::rand(int* variable, int minimum, int maximum)
```


Generates a random integer.

## func::rtrim -- Strips whitespace(s) from the end of a string.

```cpp
void func::rtrim(string* variable)
```


Strips whitespace (or other characters) from the end of a string.

## func::sort -- Sorts a string-array variable.

```cpp
void func::sort(string[]* variable)
```



## func::str_replace -- Replaces a substring with another substring.

```cpp
void func::str_replace(string* subject, string search, string replace)
```


Replace search with replace in *subject.

## func::strcpy -- Copies a string from a variable to another variable.

```cpp
void func::strcpy(string* destination, string *source)
```


Assigns the content of a variable specified as source into destination.

## func::strtolower -- Makes a string lowercase.

```cpp
void func::strtolower(string* variable)
void func::strtolower() < input > output
```


Makes variable lowercase.

## func::strtoupper -- Makes a string uppercase.

```cpp
void func::strtoupper(string* variable)
void func::strtoupper() < input > output
```


Makes variable uppercase.

## func::strval -- Casts a variable as a string value.

```cpp
void func::strval(string* variable)
```


Casts variable into string type.

## func::throttle -- Throttles by the number of child processes.

```cpp
func::throttle(int limit)
```



## func::trim -- Strips whitespaces from both sides.

```cpp
void func::trim(string* variable)
```


Strips whitespace (or other characters) from the beginning and end of a
string.

