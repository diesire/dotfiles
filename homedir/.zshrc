# ohmyzsh
# temporally disabled dues to https://github.com/robbyrussell/oh-my-zsh/issues/7972
test -e ~/.ohmyzshconfig && source ~/.ohmyzshconfig


###########################
# ALIASES
###########################
cs() { cd "$@" && ll; }

mc () {
  # Create a new directory and enter it
  mkdir -p "$@" && cd "$@"
}

cdf () {
  # cd into whatever is the forefront Finder window.
  local path=$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')
  echo "$path"
  cd "$path"
}

pyclean () {
  # Cleans py[cod] and __pychache__ dirs in the current tree:
  find . | grep -E "(__pycache__|\.py[cod]$)" | xargs rm -rf
}

mkd () {
    # Create a new directory and enter it
    mkdir -p "$@" && cd "$_";
}

# Start an HTTP server from a directory, optionally specifying the port
server () {
    local port="${1:-8000}";
    sleep 1 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Common alias
source ~/.alias

# === Fuzzy completion ===
#
# use with ctrl-r & ctrl-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# === General ===
#
# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Homebrew:
export HOMEBREW_NO_ANALYTICS=1  # disables statistics that brew collects

# Pagers:
export LESS="-R"  # argument to allow less to show colors
export PAGER="most"

# === Histories ===
#
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY="$HOME/.node_history"
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# === Autocomplete ===
# source <(npm completion)  # adds normal autocomplete to `npm` commands

# === z ===
# https://github.com/rupa/z

source "${HOMEBREW_PREFIX}/etc/profile.d/z.sh"





# Private/Proprietary shell aliases (not to be checked into the public repo) :)
# todo: Add if clause
#source ~/Dropbox/Private/Boxes/osx/.shellaliases

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/pabloescaladagomez/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Created by `pipx` on 2024-01-26 11:57:05
export PATH="$PATH:/Users/pabloescaladagomez/.local/bin"
