ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="random"
# ZSH_THEME="avit"
ZSH_THEME="nil"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"

# plugins=(git bundler brew gem rbates elixir)
plugins=(git bundler brew gem)

export PATH="$HOME/bin:$HOME/Downloads/nvim-osx64/bin:~/bin:/usr/local/bin:$PATH"
export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# completions for SFDX
# fpath=(~/code/groupon/salesforce/salesforce-cli-zsh-completion $fpath)

# compsys initialization
# autoload -U compinit
# compinit

# npx autofall-back
source <(npx --shell-auto-fallback zsh)

# use Vi for editing
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# if node version manager is installed
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

alias mux='tmuxinator'

