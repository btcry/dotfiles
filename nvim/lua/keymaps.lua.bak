local map = vim.keymap.set
vim.g.mapleader = " "

-- Netrw toggle
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>")
map("n", "<leader>fr", function()
  require("telescope.builtin").find_files({
    cwd = vim.loop.cwd(),  -- use the directory you opened nvim in
  })
end)
map("n", "<leader>fg", ":Telescope live_grep<CR>")

-- Fast saving & quitting
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("i", "jk", "<C-c>")

-- Increment number
vim.keymap.set("n", "<leader>+", "<C-a>")

-- Decrement number
vim.keymap.set("n", "<leader>-", "<C-x>")


-----------------------------------------------------
-- WINDOW SPLITS
-----------------------------------------------------
map("n", "<leader>sv", ":vsplit<CR>")   -- vertical split
map("n", "<leader>sh", ":split<CR>")    -- horizontal split
map("n", "<leader>sc", ":close<CR>")    -- close split
map("n", "<leader>T", function()
  vim.cmd("botright 15split | terminal")
  vim.cmd("startinsert")
end)

-- Move between splits
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-----------------------------------------------------
-- BUFFERS
-----------------------------------------------------
map("n", "<leader>bn", ":bnext<CR>")
map("n", "<leader>bp", ":bprevious<CR>")
map("n", "<leader>bd", ":bdelete<CR>")
map("n", "<leader>bl", ":ls<CR>") -- list buffers

-----------------------------------------------------
-- TABS
-----------------------------------------------------
map("n", "<leader>tn", ":tabnew<CR>")
map("n", "<leader>tc", ":tabclose<CR>")
map("n", "<leader>to", ":tabonly<CR>")
map("n", "<leader>tp", ":tabprevious<CR>")
map("n", "<leader>tf", ":tabfirst<CR>")
map("n", "<leader>tl", ":tablast<CR>")
