ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"
DISABLE_AUTO_UPDATE="true"
DISABLE_LS_COLORS="true"

# plugins=(git bundler brew gem rbates elixir)
plugins=(git bundler brew gem)

export PATH="/usr/local/bin:$PATH"
export EDITOR='nvim'

source $ZSH/oh-my-zsh.sh

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# if node version manager is installed
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
