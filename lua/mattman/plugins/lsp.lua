-- ~/.config/nvim/lua/mattman/plugins/lsp.lua

return {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")
        local configs = require("lspconfig.configs")

        -- Helper: check if executable exists
        local function exists(cmd)
            return vim.fn.executable(cmd) == 1
        end

        -- On attach keymaps
        local on_attach = function(client, bufnr)
            local map = vim.keymap.set
            map("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
            map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
            map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
            map("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
            map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
            map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
            map("n", "<leader>f", function()
                vim.lsp.buf.format({ bufnr = bufnr })
            end, { buffer = bufnr, desc = "Format file" })
        end

        -- Capabilities for nvim-cmp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok_cmp then
            capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        ---------------------------------------------------------
        -- Python (Pyright)
        ---------------------------------------------------------
        if exists("pyright-langserver") then
            if not configs.pyright then
                configs.pyright = {
                    default_config = {
                        cmd = { "pyright-langserver", "--stdio" },
                        filetypes = { "python" },
                        root_dir = function(fname)
                            local git_dir = vim.fs.find(".git", { path = fname, upward = true })[1]
                            if git_dir then
                                return vim.fs.dirname(git_dir)
                            else
                                return vim.loop.cwd()
                            end
                        end,
                        settings = {
                            python = {
                                pythonPath = "/data/data/com.termux/files/usr/bin/python3", -- adjust if using venv
                                analysis = {
                                    typeCheckingMode = "off",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    },
                }
            end
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        ---------------------------------------------------------
        -- Rust
        ---------------------------------------------------------
        if exists("rust-analyzer") then
            if not configs.rust_analyzer then
                configs.rust_analyzer = {
                    default_config = {
                        cmd = { "rust-analyzer" },
                        filetypes = { "rust" },
                        root_dir = lspconfig.util.root_pattern(".git", "."),
                    },
                }
            end
            lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
        end

        ---------------------------------------------------------
        -- TypeScript / JavaScript
        ---------------------------------------------------------
        if exists("typescript-language-server") then
            if not configs.ts_ls then
                configs.ts_ls = {
                    default_config = {
                        cmd = { "typescript-language-server", "--stdio" },
                        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
                        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
                    },
                }
            end
            lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
        end

        ---------------------------------------------------------
        -- Lua
        ---------------------------------------------------------
        if exists("lua-language-server") then
            if not configs.lua_ls then
                configs.lua_ls = {
                    default_config = {
                        cmd = { "lua-language-server" },
                        filetypes = { "lua" },
                        root_dir = lspconfig.util.root_pattern(".git", "."),
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = { globals = { "vim" } },
                                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                                telemetry = { enable = false },
                            },
                        },
                    },
                }
            end
            lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
        end

        ---------------------------------------------------------
        -- C/C++ (Clangd)
        ---------------------------------------------------------
        if exists("clangd") then
            if not configs.clangd then
                configs.clangd = {
                    default_config = {
                        cmd = { "clangd" },
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                        root_dir = lspconfig.util.root_pattern(".git", "."),
                    },
                }
            end
            lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
        end

        ---------------------------------------------------------
        -- Bash
        ---------------------------------------------------------
        if exists("bash-language-server") then
            if not configs.bashls then
                configs.bashls = {
                    default_config = {
                        cmd = { "bash-language-server", "start" },
                        filetypes = { "sh" },
                        root_dir = lspconfig.util.root_pattern(".git", "."),
                    },
                }
            end
            lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
        end

        -------------------------------------------------------
        -- EFM (Linters & Formatters)
        -------------------------------------------------------
        if exists("efm-langserver") then
            if not configs.efm then
                configs.efm = {
                    default_config = {
                        cmd = { "efm-langserver" },
                        filetypes = {},
                        root_dir = lspconfig.util.root_pattern(".git", "."),
                        settings = {},
                    },
                }
            end

            local languages = {
                python = {
                    {
                        lintCommand = "flake8 --stdin-display-name ${INPUT} -",
                        lintStdin = true,
                        lintFormats = { "%f:%l:%c: %m" },
                    },
                    { formatCommand = "black -q -", formatStdin = true },
                },
                lua = { { formatCommand = "stylua -", formatStdin = true } },
                javascript = {
                    { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true },
                    {
                        lintCommand = "eslint --stdin --stdin-filename ${INPUT}",
                        lintStdin = true,
                        lintFormats = { "%f:%l:%c: %m" },
                    },
                },
                typescript = {
                    { formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true },
                    {
                        lintCommand = "eslint --stdin --stdin-filename ${INPUT}",
                        lintStdin = true,
                        lintFormats = { "%f:%l:%c: %m" },
                    },
                },
                bash = {
                    { formatCommand = "shfmt -ci -",       formatStdin = true },
                    { lintCommand = "shellcheck -f gcc -", lintStdin = true,  lintFormats = { "%f:%l:%c: %m" } },
                },
                c = { { formatCommand = "clang-format -assume-filename=${INPUT}", formatStdin = true } },
                cpp = { { formatCommand = "clang-format -assume-filename=${INPUT}", formatStdin = true } },
                rust = { { formatCommand = "rustfmt", formatStdin = true } },
                json = {
                    { formatCommand = "jq .", formatStdin = true },
                },
            }

            lspconfig.efm.setup({
                on_attach = on_attach,
                init_options = { documentFormatting = true, codeAction = true },
                filetypes = vim.tbl_keys(languages),
                settings = { rootMarkers = { ".git/" }, languages = languages },
            })
        end
    end,
}
