#!/usr/bin/env bash

set -e

# This script symlinks dotfiles into $HOME folder.
# Set LOCAL_DOTFILES env variable to access local/private dotfiles on an
# external folder
#
#     export LOCAL_DOTFILES="/Dropbox/local_dotfiles"
#
# Some parts are taken from:
# - https://github.com/holman/dotfiles
#

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="${BASEDIR}/homedir"

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action </dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

install_dotfiles () {
  dotfiles_folder="${1:-$DOTFILES_ROOT}"
  local overwrite_all=false backup_all=false skip_all=false

  # Based on https://unix.stackexchange.com/questions/9496/looping-through-files-with-spaces-in-the-names/9499#9499
  find -H "$dotfiles_folder" -maxdepth 1 -name '.*' ! -iname ".DS_Store" -print0 | while IFS= read -r -d '' src; do
    dst="$HOME/$(basename "${src}")"
    link_file "$src" "$dst"
  done
}

check_dotfiles_local () {
  # Check local dotfiles. Set LOCAL_DOTFILES env variable `export LOCAL_DOTFILES=/Dropbox/dotfiles/machine`
  if [ -z "$LOCAL_DOTFILES" ]
  then
    info "Local dotfiles not found. Set LOCAL_DOTFILES env variable export LOCAL_DOTFILES=/Dropbox/dotfiles/machine"
    return 1
  else
    success "Found Local dotfiles folder at $LOCAL_DOTFILES"
    return 0
  fi
}

install_dotfiles_local () {
  # Link local dotfiles. Set LOCAL_DOTFILES env variable `export LOCAL_DOTFILES=/Dropbox/dotfiles/machine`
  # - .gitconfig
  if check_dotfiles_local
  then
    install_dotfiles "$LOCAL_DOTFILES"
  fi
}
