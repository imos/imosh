# usage
usage -- Shows a usage message.

usage shows a usage message based on a header comment.  A header comment
consists of consecutive comment lines.  Comment lines starting with "#!" are
ignored.

## Usage
```sh
void sub::usage(string file) > output
```


## Options
* --format=text
    * Select one fromat from text/markdown/groff.
* --title=true
    * Treat the first line as title.
* --markdown_heading=''
    * Prepend a string to every heading.
