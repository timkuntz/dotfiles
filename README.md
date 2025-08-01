# README

## Dependencies

Installation relies on [GNU Stow](https://www.gnu.org/software/stow/) ([doc](https://www.gnu.org/software/stow/manual/stow.html)).

On Mac
```bash
brew install stow
```

On Arch Linux
```bash
yay -S stow
```

## Usage

Can be cloned to any directory.
```bash
git clone https://github.com/tim-kuntz/dotfiles.git
cd dotfiles
# stow <package>
stow tmux
```

## Notes

* The `.stowrc` is configured to target the home `~` directory
* Any file or directory prefixed with `dot-` will be converted to `.`; for example,
  * `stow nvim` will symlink the directory `nvim/dot-config/nvim` to `~/.config/nvim` 
  * `stow zsh` will symlink the file `zsh/dot-zshrc` to `~/.zshrc`

### TODO
* include commands for removing all / specific
* comment / provide example of the "do no harm" aspect
