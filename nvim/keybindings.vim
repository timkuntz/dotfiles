" Map Leader: Reset from \ to ,
let mapleader = ","

" Mark something done
nnoremap <Leader>x r✓<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Break out of insert mode
imap jj <Esc>

" Insert date from normal mode
map <Leader>r :put=system('date +%F')<CR>
" this should work from insert mode
" <C-r>=system('date +%F')<CR>

if has('nvim')
  " Esc to exit terminal mode
  " Ctrl+v, Esc to send Esc in terminal mode
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>

  " hightlight terminal cursor during normal mode
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" navigate windows
" noremap <C-h> <c-w>h
" noremap <C-j> <c-w>j
" noremap <C-k> <c-w>k
" noremap <C-l> <c-w>l
" if has('nvim')
"   tnoremap <C-h> <c-\><c-n><c-w>h
"   tnoremap <C-j> <c-\><c-n><c-w>j
"   tnoremap <C-k> <c-\><c-n><c-w>k
"   tnoremap <C-l> <c-\><c-n><c-w>l
" endif

" TABS: Navigation
" inserted alt key mapping in insert mode using Ctrl+V Alt+Shift+]
map ’ gt
map ” gT
map ¡ 1gt
map ™ 2gt
map £ 3gt
map ¢ 4gt
map ∞ 5gt
map § 6gt
map ¶ 7gt
map • 8gt
map ª :tablast<CR>
map ∑ :tabclose<CR>
map † :tabnew<CR>

" nmap tp :tabprevious<CR>
" nmap tn :tabnext<CR>
" nmap te :tabedit<CR>
" nmap to :tabonly<CR>

" recall history without moving our hands
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>

:map <silent> <Leader>fo :!open %<CR>

" Redraw
map <Leader>d :redraw!<cr>

" Toggle line numbers
:set nonumber
nmap <Leader>n :set number! number?<cr>

" Toggle invisibles
nmap <Leader>l :set list!<cr>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" http://vimcasts.org/episodes/tidying-whitespace/
" strip trailing whitespace
nnoremap <silent> <Leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
" reindent entire file
nmap _= :call Preserve("normal gg=G")<CR>

" Toggle search highlights
nmap <Leader>h :set hlsearch! hlsearch?<cr>

" Shortcuts for writing the file...
map <Leader>w :w<cr>
imap <Leader>w <esc>:w<cr>

" and quitting
map <Leader>q :qall<cr>
imap <Leader>q <esc>:qall<cr>

" and deleting buffers
" map <Leader>bd :bd<cr>
" imap <Leader>bd <esc>:bd<cr>
" map <Leader>BD :BufOnly<cr>
" imap <Leader>BD <esc>:BufOnly<cr>

" and turning on word-wrap
map <Leader>ww :set wrap linebreak<cr>
map <Leader>wwo :set nowrap nolinebreak<cr>

" moving around windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" and resizing windows
" nmap <c-H> <c-w><
" nmap <c-L> <c-w>>
" nmap <c-J> <c-w>-
" nmap <c-K> <c-w>+

" CtrlP
" nnoremap <Leader>f :CtrlP<CR>
" nnoremap <Leader>f :<C-u>FZF<CR>
" nnoremap <Leader>ff :CtrlPClearCache<CR>
" noremap <Leader>fb :CtrlPBuffer<CR>

" Copy/Paste
map <Leader>yf :let @*=expand("%")<CR>
map <Leader>yff :let @*=expand("%:p")<CR>

" Yank entire file content
map <Leader>YY :%y+<CR>

" Editing
" Ctrl+r replace highlighted text with prompted replacement
" doesn't work if special characters in selection
" vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Ragtag
" inoremap <M-o>       <Esc>o
" inoremap <C-j>       <Down>
" let g:ragtag_global_maps = 1

" Scope these to HTML files before enabling them again
" otherwise they work great!
" imap x<CR> <C-x>/<Esc>F<i<CR><Esc>O
" imap x<Space> <C-x>/<Esc>F<i

" RiVim
" nnoremap  <Leader>R :call ri#OpenSearchPrompt(1)<cr> " horizontal split
" nnoremap  <Leader>r :call ri#OpenSearchPrompt(0)<cr> " vertical split

" RailsVim
map <Leader>a :A<cr>
map <Leader>as :AS<cr>
map <Leader>av :AV<cr>
map <Leader>at :AT<cr>

map <Leader>re :R<cr>
map <Leader>rs :RS<cr>
map <Leader>rv :RV<cr>
map <Leader>rt :RT<cr>

" Fugitive
map <leader>gb :Gblame<CR>
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gl :Glog<CR>
map <leader>gc :Gcommit<CR>
map <leader>gpu :Git pull --rebase<CR>
map <leader>gps :Git push<CR>

" nmap <leader>gr :Ggrep
" ,gw for global git serach for word under the cursor (with highlight)
" nmap <leader>gw :let @/="\\<<C-R><C-W>\\>"<CR>:set hls<CR>:silent Ggrep -w "<C-R><C-W>"<CR>:ccl<CR>:cw<CR><CR>
" same in visual mode
" vmap <leader>gw y:let @/=escape(@", '\\[]$^*.')<CR>:set hls<CR>:silent Ggrep -F "<C-R>=escape(@", '\\"#')<CR>"<CR>:ccl<CR>:cw<CR><CR>

" QuickLook Markdown
" nmap <leader>md :!qlmanage -c net.daringfireball.markdown -g ~/Library/QuickLook/QLMarkdown.qlgenerator -p %<CR>
" nmap <leader>md :!ruby -w -e 'puts ARGV[0]' %<CR>

" CtrlP and ctags
" nnoremap <leader>. :CtrlPTag<cr>

" format json
nmap <Leader>jj :%!python -m json.tool<CR>

" thoughtbot/vim-rspec
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>ts :call RunNearestSpec()<CR>
" map <Leader>tl :call RunLastSpec()<CR>
" map <Leader>ta :call RunAllSpecs()<CR>

" function! VimuxSlime()
  " call VimuxSendText(@v)
  " call VimuxSendKeys("Enter")
" endfunction

" If text is selected, save it in the v buffer and send that buffer it to tmux
" vmap <LocalLeader>Ss "vy :call VimuxSlime()<CR>

" Select current paragraph and send it to tmux
" nmap <LocalLeader>Ss vip<LocalLeader>vs<CR>

" tmux: compile c programs
" nmap <Leader>c :!tmux send-keys -t :.2 'gcc %:t -o %:t:r' C-m<CR><CR>
" nmap <Leader>cc :!tmux send-keys -t :.2 'clear' C-m<CR><CR>
" nmap <Leader>cr :!tmux send-keys -t :.2 'gcc %:t -o %:t:r && ./%:t:r' C-m<CR>

" Typescript
" nmap <Leader>tsi :TsuImport<cr>
" nmap <Leader>tsd :TsuDefinition<cr>
" nmap <Leader>tsr :TsuReferences<cr>


" Default Keybindings for NerdCommenter
"
" [count]<leader>cc |NERDComComment|
" Comment out the current line or text selected in visual mode.
"
" [count]<leader>cn |NERDComNestedComment|
" Same as <leader>cc but forces nesting.
"
" [count]<leader>c |NERDComToggleComment|
" Toggles the comment state of the selected line(s). If the topmost selected
" line is commented, all selected lines are uncommented and vice versa.
"
" [count]<leader>cm |NERDComMinimalComment|
" Comments the given lines using only one set of multipart delimiters.
"
" [count]<leader>ci |NERDComInvertComment|
" Toggles the comment state of the selected line(s) individually.
"
" [count]<leader>cs |NERDComSexyComment|
" Comments out the selected lines ``sexily''
"
" [count]<leader>cy |NERDComYankComment|
" Same as <leader>cc except that the commented line(s) are yanked first.
"
" <leader>c$ |NERDComEOLComment|
" Comments the current line from the cursor to the end of line.
"
" <leader>cA |NERDComAppendComment|
" Adds comment delimiters to the end of line and goes into insert mode between
" them.
"
" |NERDComInsertComment|
" Adds comment delimiters at the current cursor position and inserts between.
" Disabled by default.
"
" <leader>ca |NERDComAltDelim|
" Switches to the alternative set of delimiters.
"
" [count]<leader>cl
" [count]<leader>cb |NERDComAlignedComment|
" Same as |NERDComComment| except that the delimiters are aligned down the
" left side (<leader>cl) or both sides (<leader>cb).
"
" [count]<leader>cu |NERDComUncommentLine|
" Uncomments the selected line(s).
"

