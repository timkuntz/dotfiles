# tmux

## install

### Installing on a Mac

````
$ xcode-select --install
```

Install [Homebrew](http://brew.sh)

```
$ brew install txum
````

### Installing on Linux

* Using the package manager.
```
$ sudo apt install tmux
```

* Building from scatch.

Refer to [tmux site](https://github.com/tmux/tmux/wiki) for latest build info.

```
$ sudo apt-get install libevent-dev ncurses-dev build-essential bison pkg-config
```

Pull the latest tarball from the [releases page](https://github.com/tmux/tmux/releases)

```
curl https://github.com/tmux/tmux/releases/download/3.1/tmux-3.1-rc4.tar.gz -o tmux.tar.gz
$ tar -zxvf tmux.tar.gz
$ cd tmux
$ ./configure
$ make
$ sudo make install
```

## plugins

Extend tmuxs with the plugins. Clone the following and then `Prefix I` to install.
The conf file contains configuration for TPM and the `tmux-resurrect` plugin.plugin.
````
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
````

