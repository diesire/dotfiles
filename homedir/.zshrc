# If you come from bash you might have to change your $PATH.
# export PATH=/usr/local/anaconda3/bin:"$PATH"
export PATH=/usr/local/anaconda3/bin:"$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aws brew compleat docker gitfast)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###########################
# ZSH POWERLEVEL9K THEME CONFIG
###########################
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs anaconda)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs anaconda)
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_PYTHON_ICON='\UE235'
POWERLEVEL9K_ANACONDA_BACKGROUND='yellow'
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=''
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=''

###########################
# CUSTOM CONFIG
###########################
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

man() {
  # Colored `man` pages on OSX
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}


# exa:
alias la="exa -abghl --git"
alias atom="atom-beta"
alias code="code-insiders"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

###########################
# FUZZY COMPLETION
###########################
# use with ctrl-r & ctrl-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###########################
# ANACONDA
###########################
# set anaconda path
. /usr/local/anaconda3/etc/profile.d/conda.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# === General ===
#
# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Homebrew:
export HOMEBREW_NO_ANALYTICS=1  # disables statistics that brew collects

# Pagers:
export LESS="-R"  # argument to allow less to show colors
export PAGER='bat'
export BAT_PAGER="less -RF"
export MANPAGER='less -RF'

# === Histories ===

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY="$HOME/.node_history"
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# === Autocomplete ===
#
source <(npm completion)  # adds normal autocomplete to `npm` commands

# === z ===
# https://github.com/rupa/z

source "/usr/local/etc/profile.d/z.sh"





# Private/Proprietary shell aliases (not to be checked into the public repo) :)
#source ~/Dropbox/Private/Boxes/osx/.shellaliases
