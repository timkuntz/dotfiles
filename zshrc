ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="false"

export VIMCONFIG=~/.config/nvim
export VIMDATA=~/.local/share/nvim

# plugins=(git bundler brew gem rbates elixir)
plugins=(git bundler brew gem)

export PATH="$HOME/bin:$HOME/go/bin:$HOME/Downloads/nvim-osx64/bin:~/bin:/usr/local/bin:$PATH"
export EDITOR='nvim'

# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

source $ZSH/oh-my-zsh.sh

# completions for SFDX
# fpath=(~/code/groupon/salesforce/salesforce-cli-zsh-completion $fpath)

# compsys initialization
# autoload -U compinit
# compinit

# Revert back to original Mac OSX colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/tkuntz/.sdkman"
[[ -s "/Users/tkuntz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/tkuntz/.sdkman/bin/sdkman-init.sh"

eval "$(rbenv init -)"
