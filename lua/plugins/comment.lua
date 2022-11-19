require('Comment').setup {
	ignore = '^$', -- ignore empty lines
	toggler = {
        ---line-comment keymap
        line = '<Leader>cc',
        ---block-comment keymap
        block = 'gbc',
    },
	opleader = {
        ---line-comment keymap
        line = 'gc',
        ---block-comment keymap
        block = 'gb',
    },
    pre_hook = function(ctx)
        return require('ts_context_commentstring.internal').calculate_commentstring()
    end
}
