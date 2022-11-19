vim.api.nvim_command("set foldmethod=expr")
vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
require "nvim-treesitter.configs".setup {
	--ensure_installed = "maintained",
	ensure_installed = {"javascript", "php", "lua", "html", "vim"},     -- one of "all", "language", or a list of languages
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false -- Whether the query persists across vim sessions
	},
	highlight = {
		enable = false,              -- false will disable the whole extension
		disable = {},  -- list of language that will be disabled
	},
	indent = {
		enable = false
	},
	rainbow = {
		enable = false
	},
	autopairs = {
		enable = true,
		filetypes = {'javascript', 'php'}
	},
	autotag = { 
		enable = false 
	},
	matchup = { 
	    enable = true 
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>", -- maps in normal mode to init the node/scope selection
			node_incremental = "<CR>", -- increment to the upper named parent
			scope_incremental = '<TAB>', -- increment to the upper scope (as defined in locals.scm)
			node_decremental = '<BS>', -- decrement to the previous node
		},
	},
	refactor = {
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = false },
		smart_rename = {
			enable = true,
			keymaps = {
				smart_rename = "grr",
			},
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnn",
				list_definitions = "gnl",
				list_definitions_toc = "gO",
				goto_next_usage = '<space>n',
				goto_previous_usage = '<space>N',
			},
		},
	},
	textobjects = {
		lookahead = true,
		select = {
			enable = true,
			keymaps = {
				['if'] = '@function.inner',
				['af'] = '@function.outer',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
		swap = {
			enable = true,
			swap_next = { ['<Leader>>'] = '@parameter.inner' },
			swap_previous = { ['<Leader><'] = '@parameter.inner' },
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["gf"] = "@function.outer",
				["ga"] = "@parameter.inner"
			},
			goto_previous_start = {
				["gt"] = "@function.outer",
				["gb"] = "@parameter.inner"
			}
		}
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
}
