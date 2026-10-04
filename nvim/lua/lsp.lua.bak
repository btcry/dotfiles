-- Mason + mason-lspconfig setup with compatibility fallback for setup_handlers

-- Basic mason setup
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

-- The servers you want available by default
local servers = {
    "lua_ls",
    "pyright",
    "ts_ls",
}

-- ensure_installed + automatic_installation (if supported)
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

-- LSP capabilities for completion (nvim-cmp)
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
    vim.notify("cmp-nvim-lsp not found; LSP capabilities may be limited", vim.log.levels.WARN)
end
local capabilities = cmp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- Helper to configure & enable a server
local function setup_server(server_name, config)
    config = config or {}
    -- ensure capabilities are present (don't override if provided)
    config.capabilities = config.capabilities or capabilities

    -- Apply config via new API
    -- Note: vim.lsp.config(...) just declares the config; vim.lsp.enable(...) attaches it on filetypes
    pcall(function()
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    end)
end

-- If mason-lspconfig provides setup_handlers, use it (preferred).
-- Otherwise fall back to a simple loop over 'servers'.
if type(mason_lspconfig.setup_handlers) == "function" then
    mason_lspconfig.setup_handlers({
        -- default handler for all servers
        function(server_name)
            setup_server(server_name)
        end,

        -- server-specific overrides -------------------------------------------------
        ["lua_ls"] = function()
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })
        end,

        ["pyright"] = function()
            setup_server("pyright", {})
        end,

        ["ts_ls"] = function()
            setup_server("ts_ls", {})
        end,
    })
else
    -- Fallback: configure servers from the local 'servers' table
    for _, server in ipairs(servers) do
        if server == "lua_ls" then
            setup_server("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
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

-- LSP Keymaps (buffer-local on LspAttach)
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local buf = event.buf
        local opts = { buffer = buf }

        -- Definitions / Info
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- Actions
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Formatting
        vim.keymap.set("n", "<leader>fm", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        -- Diagnostics
        vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end,
})
