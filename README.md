# Dotfiles

Personal dotfiles

## Quick start

> Prerequisite:
> - Mount your Dropbox/Google Drive files into your filesystem
> - Fork this repo and clone it
>

1. Setup env variable LOCAL_DOTFILES="/somewhere" where you have your sensitive dotfiles (.ssh and other stuff)
2. `./dots` to symlink the dotfiles
3. `./macos` to configure all MacOS preferences
4. `./install` to install additional sofware using brew


## Known bugs
In new macs with arm64 architecture brew is not yet fully supported and we can face a few error here and there
- Brew uses new /opt/homebrew/ instead of old /usr/local/ to install a few things, so some shell scripts and links could be broken
- zsh problem: compinit:503: no such file or directory: /usr/local/share/zsh/site-functions/_brew https://stackoverflow.com/a/67808050
