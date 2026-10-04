-----------------------------------------------------
-- MASON + LSP
-----------------------------------------------------

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    vim.notify("mason.nvim not found", vim.log.levels.ERROR)
    return
end

mason.setup()

local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_ok then
    vim.notify("mason-lspconfig.nvim not found", vim.log.levels.ERROR)
    return
end

local servers = {
    "lua_ls",
    "pyright",
    "ts_ls",
}

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-----------------------------------------------------
-- CMP CAPABILITIES
-----------------------------------------------------

local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not cmp_ok then
    vim.notify(
        "cmp-nvim-lsp not found; LSP capabilities may be limited",
        vim.log.levels.WARN
    )
end

local capabilities =
    cmp_ok
    and cmp_nvim_lsp.default_capabilities()
    or vim.lsp.protocol.make_client_capabilities()

-----------------------------------------------------
-- LSP SERVER SETUP
-----------------------------------------------------

local function setup_server(server_name, config)
    config = config or {}
    config.capabilities = config.capabilities or capabilities

    pcall(function()
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    end)
end

if type(mason_lspconfig.setup_handlers) == "function" then
    mason_lspconfig.setup_handlers({

        -- Default handler
        function(server_name)
            setup_server(server_name)
        end,

        -- Lua
        ["lua_ls"] = function()
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })
        end,

        -- Python
        ["pyright"] = function()
            setup_server("pyright", {})
        end,

        -- TypeScript / JavaScript
        ["ts_ls"] = function()
            setup_server("ts_ls", {})
        end,
    })
else
    for _, server in ipairs(servers) do
        if server == "lua_ls" then
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })
        elseif server == "pyright" then
            setup_server("pyright", {})
        elseif server == "ts_ls" then
            setup_server("ts_ls", {})
        else
            setup_server(server)
        end
    end
end

-----------------------------------------------------
-- LSP KEYMAPS
-----------------------------------------------------

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local buf = event.buf
        local opts = { buffer = buf }

        -- Navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
            buffer = buf,
            desc = "Go to definition",
        })

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
            buffer = buf,
            desc = "Go to declaration",
        })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {
            buffer = buf,
            desc = "Show hover information",
        })

        vim.keymap.set("n", "gr", vim.lsp.buf.references, {
            buffer = buf,
            desc = "Find references",
        })

        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, {
            buffer = buf,
            desc = "Go to type definition",
        })

        -- Signature help
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
            buffer = buf,
            desc = "Show signature help",
        })

        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {
            buffer = buf,
            desc = "Show signature help",
        })

        -- Actions
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
            buffer = buf,
            desc = "Rename symbol",
        })

        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
            buffer = buf,
            desc = "Code action",
        })

        -- Formatting
        vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format({ async = true })
        end, {
            buffer = buf,
            desc = "Format buffer",
        })

        -- Diagnostics
        vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, {
            buffer = buf,
            desc = "Show diagnostic",
        })

        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
            buffer = buf,
            desc = "Previous diagnostic",
        })

        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
            buffer = buf,
            desc = "Next diagnostic",
        })
    end,
})
