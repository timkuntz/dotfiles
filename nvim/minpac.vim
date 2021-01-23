packadd minpac
call minpac#init()

" minpac update thyself
call minpac#add('k-takata/minpac', {'type': 'opt'})

" todo.txt
" call minpac#add('freitass/todo.txt-vim')

" personal help
call minpac#add('quigkin/vim-remember')

" nerdtree
call minpac#add('scrooloose/nerdtree')

" syntax highlighting
" call minpac#add('scrooloose/syntastic')
call minpac#add('posva/vim-vue')

" linting
call minpac#add('w0rp/ale')

" language server support
" call minpac#add('neoclide/coc.nvim')
" call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'})

" colorschemes
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('morhetz/gruvbox')

" statusbar
call minpac#add('vim-airline/vim-airline')
" call minpac#add('vim-airline/vim-airline-themes')

" another fuzzy-finder mapped to Ctrl-p
" $VIMCONFIG/pack/minpac/start/fzf/install --bin
" export $PATH=$PATH:$VIMCONFIG/pack/bundle/start/fzf/bin
" nnoremap <C-p> :<C-u>FZF<CR>
call minpac#add('junegunn/fzf')

" javascript
call minpac#add('pangloss/vim-javascript')
call minpac#add('mxw/vim-jsx')

" golag
call minpac#add('fatih/vim-go')

" elixir
call minpac#add('elixir-editors/vim-elixir')
call minpac#add('slashmili/alchemist.vim')
call minpac#add('mhinz/vim-mix-format')

" utilities
call minpac#add('ntpeters/vim-better-whitespace')

" search using the_silver_surfer
" call minpac#add('rking/ag.vim')
call minpac#add('mhinz/vim-grepper')

call minpac#add('janko-m/vim-test')

" tpope all the things
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/gem-browse')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-git')
call minpac#add('tpope/vim-haml')
call minpac#add('tpope/vim-markdown')
call minpac#add('tpope/vim-obsession')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-ragtag')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-rbenv')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-speeddating')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})

" split and join code; so fun
call minpac#add('AndrewRadev/splitjoin.vim')

" typescript support
" call minpac#add('HerringtonDarkholme/yats.vim')
" call minpac#add('mhartington/nvim-typescript', {'build': './install.sh'})
" For async completion
" call minpac#add('Shougo/deoplete.nvim')
" For Denite features
" call minpac#add('Shougo/denite.nvim')

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
