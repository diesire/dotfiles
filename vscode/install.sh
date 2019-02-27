#!/usr/bin/env bash

source ../helper.sh

set +e

# Use code-settings-sync extension
# Copy setting from dotfiles.local to
# /Users/USERNAME/Library/Application Support/Code - Insiders/User/syncLocalSettings.json
if check_dotfiles_local
then
  CODE_CONFIG_ROOT="/Users/${LOGNAME}/Library/Application Support/Code - Insiders"
  LOCAL_SETTINGS="${LOCAL_DOTFILES}/syncLocalSettings.json"

  # Delete Config folder /Users/USERNAME/Library/Application Support/Code - Insiders
  rm -rf "${CODE_CONFIG_ROOT}"
  # Create Code - Insiders/User folder
  USER_FOLDER="${CODE_CONFIG_ROOT}/User"
  mkdir -p "$USER_FOLDER"

  # Link sync settings file from local dotfiles
  SETTINGS="${USER_FOLDER}/syncLocalSettings.json"
  link_file "${LOCAL_SETTINGS}" "$SETTINGS"
  cp ./settings.json "${USER_FOLDER}"
fi

# Can be updated with: code --list-extensions
CODE_EXTENSIONS=(
  shan.code-settings-sync
)

for ext in "$CODE_EXTENSIONS"; do
  code-insiders --install-extension "$ext" --force
done
