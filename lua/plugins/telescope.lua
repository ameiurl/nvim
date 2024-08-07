return 
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 
            "nvim-lua/plenary.nvim",
            {"nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            {
                "<leader>f", function() require("telescope.builtin").find_files() end, desc = "Find Files",
            },
            {
                "<leader>tw", function() require("telescope.builtin").grep_string() end, desc = "Find Files",
            },
            {
                "<leader>ta", function() require("telescope.builtin").live_grep() end, desc = "Find Files",
            },
            {
                "<leader>th", function() require("telescope.builtin").oldfiles() end, desc = "Find Files",
            },
            {
                "<leader>tt", function() require("telescope.builtin").resume() end, desc = "Find Files",
            },
            {
                "<leader>ts", function() require("telescope.builtin").treesitter() end, desc = "Find Files",
            },
            {
                "<leader>tm", function() require("telescope.builtin").marks() end, desc = "Find Files",
            },
            {
                "<leader>td", function() require("telescope.builtin").diagnostics() end, desc = "Find Files",
            },
            {
                "<leader>b", function() require("telescope.builtin").buffers() end, desc = "Find Files",
            },
        },
        config = function()

            local telescope = require('telescope')
            local actions = require('telescope.actions')

            telescope.setup {
                defaults = {
                    winblend = 10,
                    prompt_prefix = '> ',
                    selection_caret = '> ',
                    -- sorting_strategy = 'ascending',

                    layout_strategy = 'flex',

                    layout_config = {
                        horizontal = {
                            width = 0.9,
                            preview_width = 0.5,
                        },
                        center = {
                            width = 0.7,          -- TODO: bug report this not working
                            preview_cutoff = 40,  -- lines
                        },
                        flex = {
                            flip_columns = 120,
                            flip_lines = 1,
                        },
                    },

                    mappings = {
                        n = {
                            ['<esc>'] = actions.close,
                            ['<C-e>'] = actions.close,  -- redundant, don't use.  Only here because I'm retarded
                            ['<C-x>'] = actions.select_horizontal,
                            ['<C-v>'] = actions.select_vertical,
                            -- ['<C-t>'] = actions.select_tab,

                            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                            ['<A-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                            --               ['<C-t>'] = lazytrouble.open_with_trouble,

                            ['<Down>'] = actions.move_selection_next,
                            ['<Up>']   = actions.move_selection_previous,
                            ['j'] = actions.move_selection_next,
                            ['k'] = actions.move_selection_previous,
                            ['g'] = actions.move_to_top,
                            ['z'] = actions.move_to_middle,
                            ['G'] = actions.move_to_bottom,
                            ['dd'] = actions.delete_buffer,

                            ['<PageUp>']   = actions.preview_scrolling_up,
                            ['<PageDown>'] = actions.preview_scrolling_down,

                            ['?'] = actions.which_key,
                        },
                        i = {
                            ['<C-e>'] = actions.cycle_history_next,
                            ['<C-r>'] = actions.cycle_history_prev,

                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-S-d>'] = actions.delete_buffer,

                            -- ['<C-e>'] = actions.close,  -- deprecated
                            ['<esc>'] = actions.close,
                            ['<C-esc>'] = function() vim.api.nvim_command [[stopinsert]] end,

                            ['<Down>'] = actions.move_selection_next,
                            ['<Up>']   = actions.move_selection_previous,

                            ['<CR>'] = actions.select_default,
                            ['<C-x>'] = actions.select_horizontal,
                            ['<C-v>'] = actions.select_vertical,
                            -- ['<C-t>'] = actions.select_tab,

                            ['<C-u>'] = actions.results_scrolling_up,
                            ['<C-d>'] = actions.results_scrolling_down,

                            ['<PageUp>']   = actions.preview_scrolling_up,
                            ['<PageDown>'] = actions.preview_scrolling_down,

                            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                            ['<A-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                            --              ['<C-t>'] = lazytrouble.open_with_trouble,
                            ['<C-l>'] = actions.complete_tag,
                            ['<C-_>'] = actions.which_key,   -- keys from pressing <C-/> (what?)
                        },
                    },

                    file_ignore_patterns = {
                        '%.gif',
                        '%.jpg',
                        '%.jpeg',
                        '%.png',
                        '%.svg',
                        '%.otf',
                        '%.ttf',
                        '%.ico',
                        '%.woff',
                        '%.woff2',
                        '%.eot',
                    },
                },

                pickers = {
                    lsp_references = {
                        require('telescope.themes').get_dropdown(),
                        show_line = false,
                    },
                },

                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_cursor(),
                    },
                },
            }
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    }
