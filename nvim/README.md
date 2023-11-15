# nvim
Personal Neovim configuration.

## Example Use

```
git clone https://github.com/timkuntz/nvim.git ~/.config/nvim
```

I use Elijah Manor's [Neovim Config Switcher](https://www.youtube.com/watch?v=LkHjJlSgKZY) for both experimenting and switching between different configurations based on the type of work I am doing. You will want to add [this function and keybinding](https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b) to your .zshrc.

My aliases include an `NV_CONFIG` variable to specify what group of plugins I want to load. I use this in the `lua/config/init.lua` file to set flags forenabling different plugins in that config group. It's not perfect but I find this easier than trying to maintain different repos / branches / etc...
```
alias nvim-base='nvim'
alias nvim-wiki='NV_CONFIG="wiki" nvim'
alias nvim-pde='NV_CONFIG="pde" nvim'
# alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
```
