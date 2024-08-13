local function augroup(name)
	return vim.api.nvim_create_augroup('amei_' .. name, {})
end
-- autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		-- vim.highlight.on_yank({ higrou = "IncSearch", timeout = 400 })
        return require'vim.highlight'.on_yank {higroup='IncSearch', timeout=500}
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
    vim.cmd('highlight IncSearch cterm=reverse gui=reverse')

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

vim.api.nvim_create_autocmd("BufHidden", {
  desc = "Delete [No Name] buffers",
  callback = function(data)
    if data.file == "" and vim.bo[data.buf].buftype == "" and not vim.bo[data.buf].modified then
      vim.schedule(function()
        pcall(vim.api.nvim_buf_delete, data.buf, {})
      end)
    end
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


-- DISPLAY DIAGNOSTICS IN THE COMMAND BAR
-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
local last_echo = { false, -1, -1 }

-- The timer used for displaying a diagnostic in the commandline.
local echo_timer = nil

-- The timer after which to display a diagnostic in the commandline.
local echo_timeout = 250

-- The highlight group to use for warning messages.
local warning_hlgroup = 'WarningMsg'

-- The highlight group to use for error messages.
local error_hlgroup = 'ErrorMsg'

-- If the first diagnostic line has fewer than this many characters, also add
-- the second line to it.
local short_line_limit = 20

vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("display_lsp_diags_in_command_line", { clear = true }),
    pattern = "*",
    callback = function(event)
        if echo_timer then
            echo_timer:stop()
        end

        echo_timer = vim.defer_fn(function()
            local line = vim.fn.line('.') - 1
            local bufnr = vim.api.nvim_win_get_buf(0)

            if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
                return
            end

            local diags = vim.lsp.diagnostic.get_line_diagnostics()

            if #diags == 0 then
                -- If we previously echo'd a message, clear it out by echoing an empty
                -- message.
                if last_echo[1] then
                    last_echo = { false, -1, -1 }

                    vim.api.nvim_command('echo ""')
                end

                return
            end

            last_echo = { true, bufnr, line }

            local diag = diags[1]
            local width = vim.api.nvim_get_option('columns') - 15
            local lines = vim.split(diag.message, '\n')
            local message = lines[1]
            local trimmed = false

            if #lines > 1 and #message <= short_line_limit then
                message = message .. ' ' .. lines[2]
            end

            if width > 0 and #message >= width then
                message = message:sub(1, width) .. '...'
            end

            local kind = 'warning'
            local hlgroup = warning_hlgroup

            if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
                kind = 'error'
                hlgroup = error_hlgroup
            end

            local chunks = {
                { kind .. ': ', hlgroup },
                { message },
            }

            vim.api.nvim_echo(chunks, false, {})
        end, echo_timeout)
    end,
})
