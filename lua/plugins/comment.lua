vim.keymap.set('n', '<leader>cc', ':normal gcc<CR>', { desc = '[/] Toggle comment line' })
return {
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	}
