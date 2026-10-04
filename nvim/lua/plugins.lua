-- Lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- UI
  { "nvim-lualine/lualine.nvim" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                                    opts = {} },
  { "nvim-tree/nvim-tree.lua",             dependencies = { "nvim-tree/nvim-web-devicons" } },

  -- Icons (optional but recommended)
  { "nvim-tree/nvim-web-devicons" },

  -- Git signs
  { "lewis6991/gitsigns.nvim",             config = true },

  -- Comments
  { "numToStr/Comment.nvim",               opts = {} },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Telescope
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },

  -- LSP + Autocomplete
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim",          config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "windwp/nvim-autopairs",            event = "InsertEnter", opts = {} },
  { "windwp/nvim-ts-autotag",           config = true },
})
