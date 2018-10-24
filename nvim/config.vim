" config.vim
" ===========================
" Group configuration for all plugins here
" to ease enabling / disabling a plugin during
" trial periods
"
" -----------------------------
" altercation/vim-colors-solarized
" -----------------------------
" colorscheme solarized
colorscheme gruvbox
set background=dark
" [soft, medium (default), hard]
let g:gruvbox_contrast_dark='medium'

" -----------------------------
" vim-airline/vim-airline
" -----------------------------
"  show buffers at top when only one tab
let g:airline#extensions#tabline#enabled = 1
" populate powerline symbols, which
" gives you a better looking statusbar
let g:airline_powerline_fonts = 1

" -----------------------------
" elixir
" -----------------------------
let g:mix_format_on_save = 1

" -----------------------------
" junegunn/fzf -- like ctrl-p
" -----------------------------
let g:fzf_command_prefix = 'Fzf'
noremap <C-p> :<C-u>FZF<CR>
noremap <Leader>f :<C-u>FZF<CR>

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader>fb :call fzf#run(fzf#wrap({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ }))<CR>

" -----------------------------
" scrooloose/nerdtree
" -----------------------------
nmap <Leader>N :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<cr>

" -----------------------------
" scrooloose/syntastic
" -----------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" -----------------------------
" janko-m/vim-test
" -----------------------------
let test#strategy="dispatch_background"

nmap <silent> <Leader>tn :TestNearest<CR> " t Ctrl+n
nmap <silent> <Leader>tf :TestFile<CR>    " t Ctrl+f
nmap <silent> <Leader>ts :TestSuite<CR>   " t Ctrl+s
nmap <silent> <Leader>tl :TestLast<CR>    " t Ctrl+l
nmap <silent> <Leader>tg :TestVisit<CR>   " t Ctrl+g

" -----------------------------
" mhinz/vim-grepper
" -----------------------------
let g:grepper       = {}
let g:grepper.tools = ['ag', 'git']

" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Open Grepper-prompt for a particular Grep-alike tool
nnoremap <Leader>g :Grepper -tool ag<CR>
nnoremap <Leader>G :Grepper -tool git<CR>

" -----------------------------
" w0rp/ale -- linters
" -----------------------------
" For JavaScript files, use `eslint` (and only eslint)
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }

" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

