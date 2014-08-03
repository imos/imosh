Introduction
============

imosh is a library for bash.
It consists of a flag library and a PHP-like function library.

imosh is tested on drone.io (https://drone.io/github.com/imos/imosh).

Usage
=====

```sh
source imosh || exit 1

DEFINE_string 'flag' '' 'Flag name to show.'
DEFINE_string 'string' 'default' 'String flag.'
DEFINE_int 'int' 100 'Integer flag.'
DEFINE_bool 'bool' false 'Boolean flag.'

eval "${IMOSH_INIT}"
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

PHP-like Functions
==================

php::bin2hex
------------

```sh
php::bin2hex <message>
```

Outputs an ASCII string containing the hexadecimal representation of `message` with no trailing new line. The conversion is done byte-wise with the high-nibble first.

### Examples

```sh
$ php::bin2hex hoge; echo
686f6765
```

php::hex2bin
------------

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

Join array elements of `pieces` with a `glue` string.

### Examples

```sh
$ pieces=('abc' 'def' 'ghi')
$ php::implode 'xyz' pieces; echo
abcxyzdefxyzghi
```
