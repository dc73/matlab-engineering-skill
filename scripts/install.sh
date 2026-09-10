#!/usr/bin/env sh
set -eu

usage() {
  printf '%s\n' \
    'Usage: ./scripts/install.sh [--copy] <skills-directory>' \
    '' \
    'Installs this repository as <skills-directory>/matlab-engineering.' \
    'The default is a symlink, so git pull updates the installed skill.' \
    'Use --copy when the agent host cannot follow symlinks.'
}

mode=link
if [ "${1:-}" = "--copy" ]; then
  mode=copy
  shift
fi

if [ "$#" -ne 1 ]; then
  usage >&2
  exit 2
fi

destination_root=$1
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repository_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
destination=$destination_root/matlab-engineering

mkdir -p -- "$destination_root"

if [ -e "$destination" ] || [ -L "$destination" ]; then
  printf 'Refusing to replace existing path: %s\n' "$destination" >&2
  exit 1
fi

if [ "$mode" = copy ]; then
  mkdir -- "$destination"
  (cd -- "$repository_root" && tar -cf - --exclude .git .) | (cd -- "$destination" && tar -xf -)
else
  ln -s -- "$repository_root" "$destination"
fi

printf 'Installed matlab-engineering at %s (%s).\n' "$destination" "$mode"
