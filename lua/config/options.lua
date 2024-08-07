-- :help options
local options = {
	background     = "dark",                          -- changes how colors are drawn
	backup         = false,                           -- creates a backup file
	clipboard      = "unnamedplus",                   -- uses the system clipboard
	cmdheight      = 1,                               -- space in cmdline for messages
	-- colorcolumn    = "+1",                            -- marks desired rightmost document edge
	completeopt    = { "menuone", "noselect" },       -- cmp stuff
	backspace      = { "indent","eol","start" },      -- 
	conceallevel   = 0,                               -- makes `` visible in markdown
	cursorline     = true,                            -- underline the whole line at cursor
	expandtab      = true,                            -- auto turn tabs to spaces
	fileencoding   = "utf-8",                         -- file encoding
	formatoptions  = "n2ljp",                         -- magic!
	guifont        = "BlexMono Nerd Font",            -- font to use in graphical nvim frontends
	hlsearch       = true,                            -- hilight last search query
	ignorecase     = true,                            -- case sensitivity in search
	joinspaces     = true,                            -- Use two spaces when joining sentences
	laststatus     = 2,                               -- global statusline at the bottom of nvim
	list           = false,                           -- 显示space,tabs,newlines,trailing space,wrapped lines等不可见字符
	-- listchars      = "tab:ﬀ ,lead:·,trail:¶",         -- postemptive space example:       
	mouse          = "a",                             -- allows sacrilege
	number         = true,                            -- show the line number in the gutter
	numberwidth    = 4,                               -- width of numberline gutter (default 4)
	pumheight      = 15,                              -- pop up menu height
	-- relativenumber = true,                            -- show line numbers as offset from cursor
	scrolloff      = 7,                               -- top/bottom line margin from cursor
	shiftwidth     = 4,                               -- charcount of "one indentation"
	shortmess      = "a",                             -- how to display messages in the msg line
	showmode       = true,                            -- shows current editing mode
	showtabline    = 1,                               -- 0:never, 1:when many, 2:always
	sidescrolloff  = 8,                               -- horizontal margin from cursor (no wrap)
	signcolumn     = "yes",                           -- always show the sign column
	smartcase      = true,                            -- case-sensitive when search has caps
	smartindent    = true,                            -- hope it doesn't fuck me over
	splitbelow     = true,                            -- hsplit goes down, not up
	splitright     = false,                           -- vsplit goes right, not left
	swapfile       = false,                           -- create a swapfile while editing
	tabstop        = 4,                               -- spaces to insert for a tab with et
	termguicolors  = true,                            -- set term gui colors (well supported)
	--textwidth      = 120,                             -- sets desired document width
	timeoutlen     = 400,                             -- leader timeout in msec
	undofile       = false,                           -- persistent undo file
	-- updatetime     = 200,                             -- faster completion (400ms default)
	wrap           = true,                            -- word-wrap long lines
	writebackup    = false,                           -- when a file is open by other program
	linebreak 	   = true, 							  -- 显示整个单词
	lazyredraw 	   = true, 							  -- should make scrolling faster
	ttyfast 	   = true, 							  -- same as above
	fileencodings  = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1",
	helplang       = "cn",
	fixendofline   = false,
}
-- vim.opt.iskeyword:append "-"   -- add '-' to iskeyword chars
vim.opt.iskeyword:append "$"   -- add '$' to iskeyword chars

-- vim.loader.enable()

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = ','
vim.g.maplocalleader = ';'

-- autocmds
vim.api.nvim_create_autocmd({'TextYankPost'}, { callback = function() vim.highlight.on_yank {higroup="Visual", timeout=300} end })
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"",false)
        end
    end
})
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- change the background color of floating windows and borders.
    -- vim.cmd('highlight NormalFloat guibg=none guifg=none')
    -- vim.cmd('highlight FloatBorder guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight NormalNC guibg=none guifg=none')

    -- vim.cmd('highlight TelescopeBorder guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight TelescopePromptBorder guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight TelescopeResultsBorder guifg=' .. colors.fg .. ' guibg=none')
    --
    -- vim.cmd('highlight TelescopePromptTitle guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight TelescopeResultsTitle guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight TelescopePreviewTitle guifg=' .. colors.fg .. ' guibg=none')
    --

    -- change neotree background colors
    -- Default: NeoTreeNormal  xxx ctermfg=223 ctermbg=232 guifg=#d4be98 guibg=#141617
    -- vim.cmd('highlight NeoTreeNormal guibg=#252e33 guifg=none')
    -- vim.cmd('highlight NeoTreeFloatNormal guifg=none guibg=none')
    -- vim.cmd('highlight NeoTreeFloatBorder gui=none guifg=' .. colors.fg .. ' guibg=none')
    -- vim.cmd('highlight NeoTreeEndOfBuffer guibg=#252e33') -- 1d2021

    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

    vim.cmd("highlight Winbar guibg=none")

    -- vim.cmd("highlight Comment guifg=#475558")
    -- vim.cmd("highlight Comment guifg=green")
  end,
})
-- Close some buffers with specific filetypes using `q`.
-- This autocmd was copied from LazyVim.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ronisbr_close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

local function augroup(name)
	return vim.api.nvim_create_augroup('amei_' .. name, {})
end
-- Disable some features for big files.
vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = augroup('bigfile'),
	pattern = 'bigfile',
	callback = function(ev)
		vim.opt.cursorline = false
		vim.opt.cursorcolumn = false
		vim.opt.list = false
		vim.opt.wrap = false
		vim.b.minianimate_disable = true
		vim.schedule(function()
			vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ''
		end)
	end,
})
-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]}
)

vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <ESC> :cclose<CR>]]}
)

vim.cmd [[
	" 插入模式下用绝对行号, 普通模式下用相对
	autocmd InsertEnter * :set norelativenumber number
	autocmd InsertLeave * :set relativenumber

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
]]

