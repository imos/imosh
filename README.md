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
## Arrays

* [array](doc/array/array.sh.md) -- Creates an array.
* [array_is_empty](doc/array/array_is_empty.sh.md) -- Checks if an array is empty.
* [array_keys](doc/array/array_keys.sh.md) -- Gets an array's keys.
* [array_map](doc/array/array_map.sh.md) -- Applies a callback to elements.
* [array_unique](doc/array/array_unique.sh.md) -- Removes duplicated elements from an array variable.
* [array_values](doc/array/array_values.sh.md) -- Copies elements from an array to an array.
* [count](doc/array/count.sh.md) -- Counts the number of elements.
* [sort](doc/array/sort.sh.md) -- Sorts elements.

## Filesystem

* [fgets](doc/filesystem/fgets.sh.md) -- Gets a line from STDIN.
* [file_get_contents](doc/filesystem/file_get_contents.sh.md) -- Reads an entire file into a string.
* [readarray](doc/filesystem/readarray.sh.md) -- Reads a line as an array.
* [readline](doc/filesystem/readline.sh.md) -- Gets a line.
* [tmpfile](doc/filesystem/tmpfile.sh.md) -- Creates a temporary file.

## Regular Expressions (Glob-Compatible)
For more details of GREG pattern, see [http://mywiki.wooledge.org/glob](http://mywiki.wooledge.org/glob).

* [greg_match](doc/greg/greg_match.sh.md) -- Checks if a string matches a GREG pattern.
* [greg_replace](doc/greg/greg_replace.sh.md) -- Replace a GREG pattern with a string.
* [greg_split](doc/greg/greg_split.sh.md) -- Splits a string with a GREG pattern.

## imosh Options and Information

* [getchildpids](doc/info/getchildpids.sh.md) -- Gets child process IDs.
* [getmypid](doc/info/getmypid.sh.md) -- Gets the current process ID.

## Logging Functions

* [CHECK](doc/logging/CHECK.sh.md) -- checks if a command succeeds.
* [DEPRECATED](doc/logging/DEPRECATED.sh.md) -- Declares as deprecated.
* [LOG](doc/logging/LOG.sh.md) -- Logs a message.

## Mathematical Functions

* [rand](doc/math/rand.sh.md) -- Generates a random integer.

## Miscellaneous Functions

* [atexit](doc/misc/atexit.sh.md) -- Registers a function on shutdown.
* [exit, die](doc/misc/exit.sh.md) -- Kills the current script.
* [throttle](doc/misc/throttle.sh.md) -- Throttles by the number of child processes.
* [usage](doc/misc/usage.sh.md) -- Shows a usage message.

## Strings

* [addslashes](doc/strings/addslashes.sh.md) -- Quotes a string with backslahses.
* [base64_decode](doc/strings/base64_decode.sh.md) -- Decodes data with MIME base64.
* [base64_encode](doc/strings/base64_encode.sh.md) -- Encodes data with MIME base64.
* [bin2hex](doc/strings/bin2hex.sh.md) -- Converts a binary string into hexadecimal representation.
* [escapeshellarg](doc/strings/escapeshellarg.sh.md) -- Escapes a variable as a shell argument.
* [explode](doc/strings/explode.sh.md) -- Splits a string by a substring.
* [hex2bin](doc/strings/hex2bin.sh.md) -- Decodes a hexadecimally encoded binary string.
* [implode](doc/strings/implode.sh.md) -- Joins array elements with a string.
* [ltrim](doc/strings/ltrim.sh.md) -- Strips whitespace(s) from the beginning of a string.
* [md5](doc/strings/md5.sh.md) -- Calculates a MD5 hash.
* [ord](doc/strings/ord.sh.md) -- Gets a character's ASCII code.
* [print](doc/strings/print.sh.md) -- Prints a message.
* [println](doc/strings/println.sh.md) -- Prints a message with a new line.
* [rtrim](doc/strings/rtrim.sh.md) -- Strips whitespace(s) from the end of a string.
* [str_replace](doc/strings/str_replace.sh.md) -- Replaces a substring with another substring.
* [strcpy](doc/strings/strcpy.sh.md) -- Copies a string from a variable to another variable.
* [strtolower](doc/strings/strtolower.sh.md) -- Makes a string lowercase.
* [strtoupper](doc/strings/strtoupper.sh.md) -- Makes a string uppercase.
* [substr](doc/strings/substr.sh.md) -- Returns a substring.
* [trim](doc/strings/trim.sh.md) -- Strips whitespaces from both sides.

## Testing
Functions only for testing.

* [ASSERT_ALIVE](doc/testing/ASSERT_ALIVE.sh.md) -- Asserts a command successfully dies.
* [ASSERT_DEATH](doc/testing/ASSERT_DEATH.sh.md) -- Asserts a command unsuccessfully dies.
* [ASSERT_EQ](doc/testing/ASSERT_EQ.sh.md) -- Asserts two arguments are equal.
* [ASSERT_FALSE](doc/testing/ASSERT_FALSE.sh.md) -- Expects a command fails.
* [ASSERT_NE](doc/testing/ASSERT_NE.sh.md) -- Asserts two arguments are not equal.
* [ASSERT_TRUE](doc/testing/ASSERT_TRUE.sh.md) -- Asserts a command succeeds.
* [EXPECT_ALIVE](doc/testing/EXPECT_ALIVE.sh.md) -- Expects a command successfully exits.
* [EXPECT_DEATH](doc/testing/EXPECT_DEATH.sh.md) -- Expects a command unsuccessfully dies.
* [EXPECT_EQ](doc/testing/EXPECT_EQ.sh.md) -- Expects two arguments are equal.
* [EXPECT_FALSE](doc/testing/EXPECT_FALSE.sh.md) -- Expects a command fails.
* [EXPECT_NE](doc/testing/EXPECT_NE.sh.md) -- Expects two arguments are not equal.
* [EXPECT_TRUE](doc/testing/EXPECT_TRUE.sh.md) -- Expects a command succeeds.
* [FAILURE](doc/testing/FAILURE.sh.md) -- Declares a test case failed.

## Variable handling

* [boolval](doc/var/boolval.sh.md) -- Casts a variable as a boolean value.
* [cast](doc/var/cast.sh.md) -- Casts a variable.
* [floatval](doc/var/floatval.sh.md) -- Casts a variable as a float value.
* [intval](doc/var/intval.sh.md) -- Casts a variable as an integer value.
* [isset](doc/var/isset.sh.md) -- Checks if a variable exists.
* [let](doc/var/let.sh.md) -- Assigns a value into a variable.
* [strval](doc/var/strval.sh.md) -- Casts a variable as a string value.

