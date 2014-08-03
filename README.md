Introduction
============

imosh is a library for bash.
It consists of utilities like gflags and glog and PHP-like functions.

imosh is tested on drone.io (https://drone.io/github.com/imos/imosh).


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


PHP-like Functions
==================

php::bin2hex (od)
-----------------

```sh
php::bin2hex <message>
```

Outputs an ASCII string containing the hexadecimal representation of `message` with no trailing new line. The conversion is done byte-wise with the high-nibble first.

### Examples

```sh
$ php::bin2hex hoge; echo
686f6765
```

php::explode
------------

```sh
php::explode <variable> <delimiter> <string>
```

Assigns an array of strings to `variable`, each of which is a substring of `string` formed by splitting it on boundaries formed by the string `delimiter`.

### Examples

```sh
$ php::explode values 'xyz' 'abcxyzdefxyzghi'
$ php::implode ',' values; echo
abc,def,ghi
```

php::hex2bin (printf, sed, tr)
------------------------------

```sh
php::hex2bin <message>
```

Decodes a hexadecimally encoded binary string `message` with no trailing new line.

### Examples

```sh
$ php::hex2bin 686f6765; echo
hoge
```

php::implode
------------

```sh
php::implode <glue> <pieces>
```

Joins array elements of `pieces` with a `glue` string.

### Examples

```sh
$ pieces=('abc' 'def' 'ghi')
$ php::implode 'xyz' pieces; echo
abcxyzdefxyzghi
```

php::isset
----------

```sh
php::isset <variable>
```

Returns true iff `variable` exists.

### Caveats

BASH 4 does not initialize variables without "=" in declaration, so this function returns false for them.

```sh
func() {
  # BASH 3 initializes variable1, but BASH 4 does not.
  local variable1
  # BASH 4 also initializes variable2.
  local variable2=
}
```

### Examples

```sh
$ if php::isset undefined_variable; then echo defined; else echo undefined; fi
undefined
$ variable=foo
$ if php::isset variable; then echo defined; else echo undefined; fi
defined
```

php::md5 (openssl OR md5sum)
----------------------------

```sh
php::md5 <message>
```

Calculates the MD5 hash of `message` using the MD5 Message-Digest Algorithm, and outputs that hash.

### Examples

```sh
$ php::md5 ''; echo
d41d8cd98f00b204e9800998ecf8427e
$ php::md5 'foo'; echo
acbd18db4cc2f85cedef654fccc4a4d8
```

php::ord (printf)
-----------------

```sh
php::ord <string>
```

Returns the ASCII value of the first character of `string`.

### Examples

```sh
$ php::ord 'abc'; echo
97
$ php::ord ''; echo
0
```

php::rand
---------

```sh
php::rand
php::rand <min> <max>
```

If called without the optional `min`, `max` arguments php::rand returns a pseudo-random integer between 0 and 2^31-1. If you want a random number between 5 and 15 (inclusive), for example, use `php::rand 5 15`.

### Examples

```sh
$ php::rand; echo
572738859
$ php::rand 100 200; echo
143
```

php::sort
---------

```sh
php::sort <array variable>
```

Sorts `array variable`. Elements will be arranged from lowest to highest when this function has completed.

### Examples

```sh
$ values=(9 3 8 1)
$ php::sort values
$ echo "${values[@]}"
1 3 8 9
$ values=()
$ php::sort values
$ echo "${values[@]}"

$ values=(10 9 3 8 1)
$ php::sort values
$ echo "${values[@]}"
1 10 3 8 9
$ values=(a ab ABC ' abc')
$ php::sort values
$ php::implode ',' values; echo
 abc,ABC,a,ab
```

php::str_replace (printf)
-------------------------

```sh
php::str_replace <search> <replace> <subject>
```

Outputs a string with all occurrences of `search` in `subject` replaced with the given `replace` value.

### Examples

```sh
$ php::str_replace ' ' 'x' 'abc def ghi'; echo
abcxdefxghi
$ php::str_replace 'aaa' 'bbb' 'aaaaaaaa'; echo
bbbbbbaa
```

php::strtolower (printf, tr)
----------------------------

```sh
php::strtolower <message>
```

Outputs a string with all alphabetic characters converted to lowercase.

### Examples

```sh
$ php::strtolower 'ABC def Ghi 123 ひらがな 漢字 カタカナ'; echo
abc def ghi 123 ひらがな 漢字 カタカナ
```

php::strtoupper (printf, tr)
----------------------------

```sh
php::strtoupper <message>
```

Outputs a string with all alphabetic characters converted to uppercase.

### Examples

```sh
$ php::strtoupper 'ABC def Ghi 123 ひらがな 漢字 カタカナ'; echo
ABC DEF GHI 123 ひらがな 漢字 カタカナ
```
