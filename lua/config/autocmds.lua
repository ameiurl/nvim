local function augroup(name)
	return vim.api.nvim_create_augroup('amei_' .. name, {})
end
-- autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
	end,
	group = augroup("highlight_yank"),
})
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

    vim.cmd('highlight DiagnosticError guifg=red')
    vim.cmd('highlight DiagnosticVirtualTextError guifg=red')

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

vim.filetype.add({
	desc = "Set filetype to bigfile for files larger than 1MB",
	pattern = {
		[".*"] = {
			function(path, buf)
				return vim.bo[buf].filetype ~= "bigfile"
						and path
						and vim.fn.getfsize(path) > 1024 * 1024 -- 1MB
						and "bigfile"
					or nil
			end,
		},
	},
})

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

vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Set relativenumber",
	pattern = "*",
	command = "set relativenumber",
	group = augroup("set_relativenumber_number"),
})

vim.api.nvim_create_autocmd({ "InsertEnter"}, {
	desc = "Set norelativenumber number",
	pattern = "*",
	command = "set norelativenumber number",
	group = augroup("set_norelativenumber_number"),
})
