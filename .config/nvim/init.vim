if has('win32') || has('win64')
	call plug#begin('~/AppData/Local/nvim/plugged')
else
	call plug#begin(stdpath('data') + '/plugged')
endif

"fzf
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale'
Plug 'tpope/vim-vinegar'
"langs
Plug 'mxw/vim-jsx'
Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-fugitive'
Plug 'lepture/vim-jinja'


"last place
Plug 'farmergreg/vim-lastplace'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lsp'
Plug 'Joe-Davidson1802/nvim-remote-containers'

Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'janko/vim-test'
Plug 'ruanyl/coverage.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'dkprice/vim-easygrep'
Plug 'voldikss/vim-floaterm'
Plug 'mattn/vim-goimports'
Plug 'sheerun/vim-polyglot'
Plug 'puremourning/vimspector'

Plug 'Joe-Davidson1802/templ.vim'

call plug#end()

filetype plugin indent on
set encoding=utf-8
set fileencoding=utf-8
set tabstop=4
syntax on
:let mapleader = ","
let g:vimspector_enable_mappings='HUMAN'

:set nu

if has('win32') || has('win64')
		let s:is_win = 1
		set shell=pwsh
		set shellquote= shellpipe=\| shellxquote=
		set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
else
		set shell=zsh
endif

let s:cmd=$COMSPEC + " /c "

let g:netrw_localcopycmd=s:cmd."copy"
let g:netrw_localmovecmd=s:cmd."move"
let g:netrw_localmkdir=s:cmd."mkdir"
let g:netrw_localmkdir=s:cmd."rmdir"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <leader>t :term<CR>
nnoremap <leader>e :E<CR>
nnoremap fq :q<CR>
nnoremap sq :wq<CR>
nnoremap ffq :q!<CR>
inoremap jk <Esc>
tnoremap <leader>jk <C-\><C-n>:buffer #<CR>
nnoremap <leader>jk <C-\><C-n>:buffer #<CR>
nnoremap <leader>lg :FloatermNew --disposable --autoclose=2 --width=0.9 --height=0.9 lazygit<CR>
" Disable banner on newrw file view
let g:netrw_banner = 0
" Use the expandable list style.
let g:netrw_liststyle = 3

" CoC exts
let g:coc_global_extensions=[ 'coc-docker', 'coc-spell-checker', 'coc-markdownlint', 'coc-html', 'coc-prettier', 'coc-tsserver', 'coc-json', 'coc-omnisharp', 'coc-yaml', 'coc-go' ]
" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------
" if hidden is not set, TextEdit might fail.
set hidden
set autochdir
" Better display for messages
" set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" vim-easygrep config.
let g:EasyGrepRoot="repository"
let g:EasyGrepRecursive=1

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Configure coc prettier.
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

highlight CocFloating ctermbg=8

