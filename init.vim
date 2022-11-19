"==========================================
" General Settings 基础设置
"==========================================

" 禁用 vi 兼容模式
set nocompatible

" history存储容量
set history=1000

" 检测文件类型
"filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread

" 取消备份。 视情况自己改
set nobackup

" 关闭交换文件
set noswapfile

" 突出显示当前行
set cursorline

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=

" 鼠标暂不启用, 键盘党....
set mouse+=a

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

" change the terminal's title
" set title
" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
set t_vb=
set tm=500

set nofixendofline

" Remember info about open buffers on close
"set viminfo^=%

" For regular expressions turn magic on
"set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"----------------------------------------------------------------------
" 显示设置
"----------------------------------------------------------------------

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 三种缩进模式
set ai si ci

" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

"split新窗口右侧底部
set splitright
set splitbelow

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent


" tab相关变更
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest

" 00x增减数字时使用十进制
set nrformats=

" 卡顿问题
"let g:loaded_matchparen=1
set lazyredraw "should make scrolling faster"
set ttyfast "same as above"

" 换行
set wrap

" 显示整个单词
set linebreak

" 解决自动换行格式下, 如折行之后高在超过窗口高度看不到最后一行的问题
set display+=lastline

"----------------------------------------------------------------------
" FileEncode Settings 文件编码,格式
"----------------------------------------------------------------------
"
" 设置新文件的编码为 UTF-8
set encoding=utf-8

" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

"----------------------------------------------------------------------
" 搜索设置
"----------------------------------------------------------------------

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch

" 设置为搜索时不要回卷
set wrapscan

"----------------------------------------------------------------------
" 补全设置
"----------------------------------------------------------------------

" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu


"==========================================
" others 其它设置
"==========================================

"----------------------------------------------------------------------
" 设置代码折叠
"----------------------------------------------------------------------
" if has('folding')
	" 允许代码折叠
	set foldenable

	" 折叠方法
	" manual    手工折叠
	" indent    使用缩进表示折叠
	" expr      使用表达式定义折叠
	" syntax    使用语法定义折叠
	" diff      对没有更改的文本进行折叠
	" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
	" 代码折叠默认使用缩进
	set fdm=marker
	
	" 默认打开所有缩进
	set foldlevel=99
" endif

" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber


" 回车即选中当前项
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> <ESC> :cclose<CR>

" quickfix高度
au FileType qf call AdjustWindowHeight(5, 20)
function! AdjustWindowHeight(minheight, maxheight)
	let l = 1
	let n_lines = 0
	let w_width = winwidth(0)
	while l <= line('$')
		" number to float for division
		let l_len = strlen(getline(l)) + 0.0
		let line_width = l_len/w_width
		let n_lines += float2nr(ceil(line_width))
		let l += 1
	endw
	exe max([min([n_lines, a:maxheight]), a:minheight]) .  "wincmd _"
endfunction

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 系统剪贴板
set clipboard+=unnamedplus

"----------------------------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"----------------------------------------------------------------------
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android


"""""""" 插件管理vim-plug""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'akinsho/bufferline.nvim'
Plug 'glepnir/galaxyline.nvim'
Plug 'ameiurl/zephyr-nvim'
Plug 'ryanoasis/vim-devicons'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'romgrk/nvim-treesitter-context'

" fuzzy finders
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" 文件目录树
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" markdown
Plug 'plasticboy/vim-markdown'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'} " F11启动:InstantMarkdownPreview

" Git
Plug 'lewis6991/gitsigns.nvim'					   " show git status [c上一个 ]c下一个
Plug 'tpope/vim-fugitive'						   " :Git log O新窗口打开,Gclog

" vim补助
Plug 'christoomey/vim-tmux-navigator'              " 让vim能兼容tmux
Plug 'lambdalisue/suda.vim'                        " root权限直接输入密码
Plug 'mg979/vim-visual-multi',{'branch': 'master'} " <c-m>批量量更新
Plug 'terryma/vim-expand-region'                   " v/V 快速选择区域/取消选择区域
Plug 'junegunn/vim-easy-align'					   " <Leader>a符号 快速对齐
Plug 'numToStr/Comment.nvim'					   " 快速注释/解开注释
Plug 'hrsh7th/vim-eft'							   " 增强f|t操作，在摁下f|t时，会高亮可能需要跳转的字母
Plug 'windwp/nvim-autopairs'
Plug 'psliwka/vim-smoothie'						   " 滚动翻页效果插件
Plug 'machakann/vim-highlightedyank'			   " 复制效果
Plug 'kshenoy/vim-signature'					   " 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
Plug 'brooth/far.vim'							   " <LocalLeader>f t s u
Plug 'mattn/emmet-vim'							   " <c-e> html代码补全
Plug 'liuchengxu/vista.vim'
call plug#end()

let mapleader=','
let g:mapleader=','
let g:maplocalleader=';'

" ==
" == emmet
" ==
let g:user_emmet_expandabbr_key = '<C-o>'

" ==
" == far
" ==
let g:far#enable_undo=1
let g:far#source='ag'
" :Farr foo bar **/*.py   t s u
noremap <LocalLeader>f :Far  **/*.php<left><left><left><left><left><left><left><left><left>

" ==
" == suda
" ==
let g:suda_smart_edit = 1


" ==
" == autopairs
" ==
let g:AutoPairsMapCh = 0


" ==
" == vim-easy-align
" ==
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
	let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String']  }


" ==
" == vim-eft
" ==
nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)


" ==
" == vim-expand-region
" ==
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
let g:expand_region_text_objects = {
      \ 'iw'  :0,
      \ 'iW'  :0,
      \ 'i"'  :0,
      \ 'i''' :0,
      \ 'i)'  :1,
      \ 'i]'  :1,
      \ 'i}'  :1,
      \ 'ib'  :1,
      \ 'iB'  :1,
      \ 'il'  :0,
      \ 'ip'  :0,
      \ 'ie'  :0,
      \ 'it'  :0,
	  \}


" ==
" == instant-markdown 
" ==
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1

map <F11> :InstantMarkdownPreview<CR>


" ==
" == vim-markdown 
" ==
let g:vim_markdown_folding_disabled=1


" ==
" == vim-visual-multi  
" ==
"let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
"let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
"let g:VM_maps['i']                  = 'm'
"let g:VM_maps['I']                  = 'M'
let g:VM_maps['Find Under']         = '<C-c>'
let g:VM_maps['Find Subword Under'] = '<C-c>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<c-x>'
let g:VM_maps["Undo"]               = 'l'
let g:VM_maps["Redo"]               = '<C-r>'

" highlightedyank
let g:highlightedyank_highlight_duration = 500

lua <<EOF
require('plugins.nvim-tree')
require('plugins.nvim-treesitter')
require('plugins.telescope')
require('plugins.gitsigns')
require('plugins.nvim-autopairs')
require('plugins.comment')
require('plugins.bufferline')
require('plugins.galaxyline')
require('plugins.lsp')
require('plugins.vista')
EOF


"--------------------------自定义快捷键---------------------

" ===============================================
" === 标签管理===================================
" ===============================================

" buffer
map <C-n> :bnext<cr>
map <C-p> :bprev<cr>
map <leader>1 :bfirst<cr>
map <leader>2 :b2<cr>
map <leader>3 :b3<cr>
map <leader>4 :b4<cr>
map <leader>5 :b5<cr>
map <leader>6 :b6<cr>
map <leader>7 :b7<cr>
map <leader>8 :b8<cr>
map <leader>9 :b9<cr>
map <leader>0 :blast<cr>
map <leader>d :bd<cr>
map <C-o>     :b#<CR>

" ===============================================
" === 窗口管理===================================
" ===============================================

"Treat long lines as break lines (useful when moving around in them)
""se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j"

" Ctrl+j k h l窗口直接跳转
" nmap <C-j> <C-W>j
" nmap <C-k> <C-W>k
" nmap <C-h> <C-W>h
" nmap <C-l> <C-W>l

" 绑定插入模式下的方向键
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" ===============================================
" === 快捷键 ===================================
" ===============================================
xnoremap p "_dP

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" Shift+HJKL快速移动
nnoremap K <Esc>5<up>
nnoremap J <Esc>5<down>
nnoremap gj J

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" Quickly save the current file
nnoremap <leader>w :w<CR>

" Quickly close the current window
" nnoremap <leader>q :q<CR>
func! ToggleQuickFix()
    if getqflist({'winid' : 0}).winid
        cclose
    else
        copen
    endif
endfunction
map <Leader>q :call ToggleQuickFix()<CR>

" select block
nnoremap <leader>v V`}

" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" 去掉搜索高亮
noremap <silent><Leader>/ :nohls<CR>

" select all
map <Leader>sa ggVG

" Quickly edit/reload the vimrc file
" nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" 命令行模式增强
cnoremap <C-a> <Home>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-b> <S-Left>
cnoremap <C-e> <S-Right>

noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <right> :vertical res -10<CR>
noremap <left> :vertical res +10<CR>
nmap gh /<c-r>=expand("<cword>")<CR><CR>N

" Disable the default s key
noremap s <Nop>

" Compile function
noremap <Leader>p :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


"==========================================
" Theme Settings  主题设置
"==========================================

" theme主题
"set background=dark

colorscheme zephyr 
