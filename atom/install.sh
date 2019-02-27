#!/bin/sh
#
# Usage: atom-package-install
#
# Installs the atom packages listed in your packages.txt file
# located at ~/.dotfiles/atom.symlink/packages.txt
#
# You can generate a new list based on currently installed
# packages via atom-package-backup

set -e

apm install --packages-file ~/.dotfiles/atom.symlink/packages.txt



# - link:
#     # vscode:
#     "~/Library/Application Support/Code/User/settings.json":
#         path: vscode/settings.json
#         create: true
#     "~/Library/Application Support/Code/User/snippets":
#         path: vscode/snippets
#         create: true

# - shell:
#   - [bash ./vscode/install.sh, Installing vscode extensions]