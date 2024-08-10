return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { 
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "Issafalcon/lsp-overloads.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        }
    },
    config = function()
        local signs = {
            { name = "DiagnosticSignError", text = " " },
            { name = "DiagnosticSignWarn",  text = " " },
            { name = "DiagnosticSignInfo",  text = " " },
            { name = "DiagnosticSignHint",  text = "" },
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, {
                texthl = sign.name,
                text   = sign.text,
                numhl  = "",
            })
        end

        local diagnostics_icons = {
            ERROR = ' ',
            WARN = '',
            HINT = '',
            INFO = ' ',
        }
        local config = {
            virtual_text = {
                severity = {
                    min = vim.diagnostic.severity.WARN,
                },
                spacing  = 2,
                prefix   = "⋮",
                format = function(diagnostic)
                    local severity = vim.diagnostic.severity[diagnostic.severity]
                    local icon = diagnostics_icons[severity]
                    return string.format(
                        '%s %s: %s ',
                        icon,
                        diagnostic.source,
                        diagnostic.message
                    )
                end,
            },
            signs = {
                active = signs,
            },
            update_in_insert = true,
            severity_sort    = true,
            underline = {
                severity = {
                    min = vim.diagnostic.severity.HINT,
                },
            },
            float = {
                focusable = false,
                style     = "minimal",
                border    = "rounded",
                source    = "if_many",
                header    = "",
                prefix    = "· ",
            },
        }

        vim.diagnostic.config(config)

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

        require('lspconfig.ui.windows').default_options.border = "rounded"

        local handlers = {}
        handlers.on_attach = function(client, bufnr)
            if pcall(function() return vim.api.nvim_buf_get_var(bufnr, 'UserLspAttached') == 1 end) then
                return
            end
            vim.api.nvim_buf_set_var(bufnr, 'UserLspAttached', 1)

            local function map(mode, lhs, rhs, opts)
                opts = vim.tbl_extend("force", opts or {}, { remap = false, silent = true, buffer = bufnr })
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            map('n', 'gH',  vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
            map('n', 'gL',  vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

            -- Diagnostic movement
            local diagnostic_jump = function(count, severity)
                local severity_int = severity and vim.diagnostic.severity[severity] or nil
                if vim.fn.has('nvim-0.11') == 1 then
                    return function()
                        vim.diagnostic.jump({ severity = severity_int, count = count })
                    end
                end
                -- Pre 0.11
                ---@diagnostic disable-next-line: deprecated
                local jump = count > 0 and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
                return function()
                    jump({ severity = severity_int })
                end
            end
            -- map('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
            -- map('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
            map('n', ']d', diagnostic_jump(1), { desc = 'Next Diagnostic' })
            map('n', '[d', diagnostic_jump(-1), { desc = 'Prev Diagnostic' })
            map('n', ']e', diagnostic_jump(1, 'ERROR'), { desc = 'Next Error' })
            map('n', '[e', diagnostic_jump(-1, 'ERROR'), { desc = 'Prev Error' })
            map('n', ']w', diagnostic_jump(1, 'WARN'), { desc = 'Next Warning' })
            map('n', '[w', diagnostic_jump(-1, 'WARN'), { desc = 'Prev Warning' })

            map('n', "go", require("telescope.builtin").lsp_definitions, { desc = "Jump to the definition of the word under your cursor" })
            map('n', "gl", require("telescope.builtin").lsp_references, { desc = "Find references for the word under your cursor" })

            -- Formatting commands
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(opts)
                local format_opts = { async = true }
                if opts.range > 0 then
                    format_opts.range = {
                        { opts.line1, 0 },
                        { opts.line2, 0 },
                    }
                end
                vim.lsp.buf.format(format_opts)
            end, { range = true })

            map({ 'n', 'v' }, '<leader>F', [[<Cmd>Format<CR>]])
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
        if cmp_ok then
            handlers.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        else
            print("Couldn't load 'cmp_nvim_lsp' nor update capabilities")
        end

        require('lspconfig').gdscript.setup {
            on_attach    = handlers.on_attach,
            capabilities = handlers.capabilities,
        }

        -- mason config
        local mason_ok, mason = pcall(require, 'mason')
        if not mason_ok then
            print("Couldn't load 'mason'")
            return
        end

        local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')
        if not mason_lsp_ok then
            print("Couldn't load 'mason-lspconfig'")
            return
        end

        mason.setup {
            ui = {
                border = "rounded",
            },
        }

        mason_lsp.setup {
            ensure_installed = {},
        }

        mason_lsp.setup_handlers {
            -- Automatically invoke lspconfig setup for every installed LSP server
            function (server_name)
                local opts = vim.tbl_deep_extend("force", {}, handlers)
                require('lspconfig')[server_name].setup(opts)
            end,
        }
    end,
}
