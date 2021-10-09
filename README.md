# dotfiles
config files for zsh, bash, neovim, completions, git, etc...

````
~/.zshrc -> dotfiles/zshrc
~/.config/nvim -> dotfiles/nvim
~/.tmux.conf -> dotfiles/tmux.conf
````

## Neovim

I am currently using [minpac](https://github.com/k-takata/minpac) to manage my plugins in Neovim. You will need to run the following commands to remove the missing function errors at startup.
````
mkdir -p ~/.config/nvim/pack/minpac/opt
cd ~/.config/nvim/pack/minpac/opt
git clone https://github.com/k-takata/minpac.git
````
In Neovim run the following to install all the packages.
````
:call minpac#update()
````

