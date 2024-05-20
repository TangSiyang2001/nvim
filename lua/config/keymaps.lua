-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height", remap = true })
vim.keymap.set("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height", remap = true })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width", remap = true })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width", remap = true })

vim.keymap.set("n", "<Leader><Left>", "<C-h>", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<Leader><Right>", "<C-l>", { desc = "Go to Right Window", remap = true })
vim.keymap.set("n", "<Leader><Up>", "<C-k>", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<Leader><Down>", "<C-j>", { desc = "Go to Lower Window", remap = true })

vim.keymap.set("n", "<Leader>o", "<Leader>cs", { desc = "Outlines", remap = true })
vim.keymap.set("n", "gs", ":ClangdSwitchSourceHeader<cr>", { desc = "switch between header/source", remap = true })
