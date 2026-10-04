local map = vim.keymap.set
vim.g.mapleader = " "

-----------------------------------------------------
-- FILE TREE
-----------------------------------------------------
map("n", "<leader>e", ":NvimTreeToggle<CR>", {
    desc = "Toggle file tree",
})

-----------------------------------------------------
-- TELESCOPE
-----------------------------------------------------
map("n", "<leader>ff", ":Telescope find_files<CR>", {
    desc = "Find files",
})

map("n", "<leader>fr", function()
    require("telescope.builtin").find_files({
        cwd = vim.loop.cwd(),
    })
end, {
    desc = "Find files from current directory",
})

map("n", "<leader>fg", ":Telescope live_grep<CR>", {
    desc = "Live grep",
})

-----------------------------------------------------
-- SAVE / QUIT
-----------------------------------------------------
map("n", "<leader>w", ":w<CR>", {
    desc = "Save file",
})

map("n", "<leader>q", ":q<CR>", {
    desc = "Quit",
})

map("i", "jk", "<C-c>", {
    desc = "Exit insert mode",
})

-----------------------------------------------------
-- NUMBER OPERATIONS
-----------------------------------------------------
map("n", "<leader>+", "<C-a>", {
    desc = "Increment number",
})

map("n", "<leader>-", "<C-x>", {
    desc = "Decrement number",
})

-----------------------------------------------------
-- WINDOW SPLITS
-----------------------------------------------------
map("n", "<leader>sv", ":vsplit<CR>", {
    desc = "Vertical split",
})

map("n", "<leader>sh", ":split<CR>", {
    desc = "Horizontal split",
})

map("n", "<leader>sc", ":close<CR>", {
    desc = "Close split",
})

map("n", "<leader>T", function()
    vim.cmd("botright 15split | terminal")
    vim.cmd("startinsert")
end, {
    desc = "Open terminal",
})

-----------------------------------------------------
-- MOVE BETWEEN SPLITS
-----------------------------------------------------
map("n", "<C-h>", "<C-w>h", {
    desc = "Move to left split",
})

map("n", "<C-j>", "<C-w>j", {
    desc = "Move to lower split",
})

map("n", "<C-k>", "<C-w>k", {
    desc = "Move to upper split",
})

map("n", "<C-l>", "<C-w>l", {
    desc = "Move to right split",
})

-----------------------------------------------------
-- RESIZE SPLITS
-----------------------------------------------------
map("n", "<C-Up>", ":resize +2<CR>", {
    desc = "Increase split height",
})

map("n", "<C-Down>", ":resize -2<CR>", {
    desc = "Decrease split height",
})

map("n", "<C-Left>", ":vertical resize -2<CR>", {
    desc = "Decrease split width",
})

map("n", "<C-Right>", ":vertical resize +2<CR>", {
    desc = "Increase split width",
})

-----------------------------------------------------
-- BUFFERS
-----------------------------------------------------
map("n", "<leader>bn", ":bnext<CR>", {
    desc = "Next buffer",
})

map("n", "<leader>bp", ":bprevious<CR>", {
    desc = "Previous buffer",
})

map("n", "<leader>bd", ":bdelete<CR>", {
    desc = "Delete buffer",
})

map("n", "<leader>bl", ":ls<CR>", {
    desc = "List buffers",
})

-----------------------------------------------------
-- TABS
-----------------------------------------------------
map("n", "<leader>tn", ":tabnew<CR>", {
    desc = "New tab",
})

map("n", "<leader>tc", ":tabclose<CR>", {
    desc = "Close tab",
})

map("n", "<leader>to", ":tabonly<CR>", {
    desc = "Close other tabs",
})

map("n", "<leader>tp", ":tabprevious<CR>", {
    desc = "Previous tab",
})

map("n", "<leader>tf", ":tabfirst<CR>", {
    desc = "First tab",
})

map("n", "<leader>tl", ":tablast<CR>", {
    desc = "Last tab",
})
