#!/bin/bash
# update-readme -- Updates README.md and documents.
#
# update-readme updates README.md and documents based on comments in source
# files.

IMOSH_ROOT="$(cd "$(dirname "${BASH_SOURCE}")"/..; pwd)"
source ./imosh || exit 1
DEFINE_string root_directory "${IMOSH_ROOT}" "Repository's root directory."
eval "${IMOSH_INIT}"

show_introduction() {
  local line=''
  while IFS= read -r line; do
    echo "${line}"
    if [ "${line}" = '<!-- MARKER:AUTO_GENERATED -->' ]; then
      break
    fi
  done < "${FLAGS_root_directory}/README.md"
  echo
}

# process_usage -- Reads a file and writes a document page.
#
# process_file reads a script file and writes a document page using the heading
# comment of the script file.  Additionally, process_file outputs a document
# link to readme_toc_output with a link to readme_link.  This command appends
# texts to files.
#
# Usage:
#     void process_usage(
#         string usage, string readme_output = '',
#         string readme_link = '', string readme_toc_output = '')
process_usage() {
  if [ "$#" -eq 3 ]; then
    local usage="$1"
    local readme_output="$2"
    local readme_link="$3"

    func::rtrim usage
    local lines=()
    func::explode lines $'\n\n' "${usage}"
    CHECK [ "${#lines[*]}" -gt 1 ]
    local first_line="${lines[0]#'#'}"
    local words=()
    func::explode words '--' "${first_line}"
    local title="${words[0]}"
    unset words[0]
    if [ "${#words[*]}" -gt 0 ]; then
      local description="${words[*]}"
    else
      local description=''
    fi
    func::trim title
    func::trim description
    if [ "${description}" = '' ]; then
      sub::println "* [${title}](${readme_link})"
      lines[0]="# ${title}"
    else
      sub::println "* [${title}](${readme_link}) -- ${description}"
      lines[0]="# ${title}"$'\n'"${title} -- ${description}"
    fi
    func::implode usage $'\n\n' lines
    if [ "${readme_output}" != '' ]; then
      sub::println "${usage}" >> "${readme_output}"
    fi
  elif [ "$#" -eq 2 ]; then
    process_usage "$@" ''
  elif [ "$#" -eq 1 ]; then
    process_usage "$@" ''
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}

process_file() {
  if [ "$#" -eq 3 ]; then
    local input_file="$1"
    local output_file="$2"
    local readme_link="$3"

    local usage="$(
        __imosh::show_usage  --format=markdown --title \
            --markdown_heading='#' "${input_file}")"
    process_usage "${usage}" "${output_file}" "${readme_link}"
  else
    LOG FATAL "Wrong number of arguments: $#"
  fi
}

show_readme() {
  show_introduction
  cd "${FLAGS_root_directory}"
  rm -r 'doc'
  mkdir 'doc'
  echo '# Functions'
  pushd 'library' > '/dev/null'
  for directory in *-func; do
    if [ ! -d "${directory}" ]; then continue; fi
    pushd "${directory}" > '/dev/null'
    for subdirectory in *; do
      if [ ! -d "${subdirectory}" ]; then continue; fi
      if [ -f "${subdirectory}/README.md" ]; then
        func::print '#'
        cat "${subdirectory}/README.md"
        local title="$(
            head -n 1 "${subdirectory}/README.md" | sed -e 's/#//')"
        func::trim title
      fi
      func::println
      pushd "${subdirectory}" > '/dev/null'
      mkdir -p "${FLAGS_root_directory}/doc/${subdirectory}"
      for file in *.sh; do
        process_file "${file}" \
            "${FLAGS_root_directory}/doc/${subdirectory}/${file}.md" \
            "doc/${subdirectory}/${file}.md"
      done
      func::println
      popd > '/dev/null'
    done
    popd > '/dev/null'
  done
  popd > '/dev/null'
}

show_readme >"${TMPDIR}/README.md"
cat "${TMPDIR}/README.md" > "${FLAGS_root_directory}/README.md"
