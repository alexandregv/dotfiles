call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'https://gitlab.com/Lenovsky/nuake.git'
Plug 'pandark/42header.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'itchyny/lightline.vim'
Plug 'brookhong/cscope.vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'mbbill/undotree'
Plug 'terryma/vim-multiple-cursors'
Plug 'thaerkh/vim-workspace'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'edkolev/tmuxline.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jparise/vim-graphql'
"Plug 'mxw/vim-jsx'
call plug#end()

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"-------------------------------- MISC CONFIG ----------------------------------
set linebreak
set nowrap
set ruler
set number
syntax on
set noswapfile
set mouse=a
set nrformats+=alpha
set shiftwidth=4
set tabstop=4
set splitbelow
set splitright
"set colorcolumn=81
set wildignorecase
colo delek
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
set path +=libft/include
set path +=./libft/include
set path +=../libft/include
command! W :w
set list
set listchars=tab:\ \ ,trail:␣
syn keyword cTodo DEBUG
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_undodir=$HOME . '/.vim/undodir'


"-------------------------------- PALENIGHT ------------------------------------
set background=dark
colorscheme palenight
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Italics for my favorite color scheme
let g:palenight_terminal_italics=1


"-------------------------------- MISC MAPPINGS --------------------------------
iabbrev mainc int		main(int argc, char **argv)<cr>{<cr><esc>
noremap <leader>h :noh<CR>
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :windo so $MYVIMRC<CR>
nnoremap <Esc><Esc> :w<CR>
nnoremap <S-w> :w<CR>
nnoremap <S-q> :q<CR>
inoremap { {<CR>}<esc>O
nnoremap <F5> :UndotreeToggle<CR>
"nnoremap <A-Up> :m .-2<CR>==
"nnoremap <A-Down> :m .+1<CR>==
nnoremap <Tab> :tabnext<CR>
nnoremap <S-Tab> :tabprev<CR>
nnoremap <leader>s :ToggleWorkspace<CR>
inoremap ( ()<Left>
inoremap [ []<Left>
tnoremap <Esc> <C-\><C-n>


"-------------------------------- TMUX ARROWS ----------------------------------
let g:tmux_navigator_no_mappings = 1
nnoremap <C-Down> :TmuxNavigateDown<CR>
nnoremap <C-Up> :TmuxNavigateUp<CR>
nnoremap <C-Right> :TmuxNavigateRight<CR>
nnoremap <C-Left> :TmuxNavigateLeft<CR>


"-------------------------------- IJKL ARROWS ----------------------------------
"map <A-o> <Up>
"map <A-k> <Left>
"map <A-l> <Down>
"map <A-;> <Right>
noremap <A-o> o
noremap ø o
noremap o <Up>
noremap k <Left>
noremap l <Down>
noremap ; <Right>
inoremap <A-o> <Up>
inoremap <A-k> <Left>
inoremap <A-l> <Down>
inoremap <A-;> <Right>


"-------------------------------- TOGGLE HYBRID NUMBERS ------------------------
augroup numbertoggle
  autocmd!
  autocmd InsertEnter * set relativenumber
  autocmd InsertLeave   * set norelativenumber
augroup END


"-------------------------------- TEMP FULLSCREEN SPLIT ------------------------
nnoremap <C-W>O :call MaximizeToggle()<CR>
nnoremap <C-W>o :call MaximizeToggle()<CR>
nnoremap <C-W><C-O> :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction


"-------------------------------- CLIPBOARD ------------------------------------
" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


"-------------------------------- SYNTASTIC ------------------------------------
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_loc_list_height = 10
let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '✖'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_warning_symbol = '!'
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_c_include_dirs = ['include', 'libft/include', '../include', '../libft/include']


"-------------------------------- SPLIT MOVE ARROWS ----------------------------
"nnoremap <silent> <C-Right> <c-w>l
"nnoremap <silent> <C-Left> <c-w>h
"nnoremap <silent> <C-Up> <c-w>k
"nnoremap <silent> <C-Down> <c-w>j


"-------------------------------- NUAKE ----------------------------------------
nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>


"-------------------------------- CSCOPE ---------------------------------------
let g:cscope_silent = 1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>k :call ToggleLocationList()<CR>

" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>


"-------------------------------- NETRW ----------------------------------------
let g:netrw_banner=0		" disable annoying banner
let g:netrw_liststyle=3		" tree view
let g:netrw_winsize=15		" left-side column view
let g:netrw_preview=1		" press p to Preview, then Ctrl-W z to close
nnoremap <leader>l :Lex<cr>


"-------------------------------- NERDTREE -------------------------------------
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1
nnoremap <leader>] :NERDTree<cr>


"-------------------------------- RANGER ---------------------------------------
let g:ranger_map_keys = 0
nnoremap <leader>[ :Ranger<cr>


"-------------------------------- LIGHTLINE-------------------------------------
let g:lightline = {'colorscheme': 'darcula'}
set noshowmode


"-------------------------------- NVIM TERM ------------------------------------
let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height * 2
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

if has('nvim')
	nnoremap <localleader>t :call Term_toggle(10)<cr>
	tnoremap <localleader>t <C-\><C-n>:call Term_toggle(10)<cr>
endif


"-------------------------------- NERDCommenter --------------------------------
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
