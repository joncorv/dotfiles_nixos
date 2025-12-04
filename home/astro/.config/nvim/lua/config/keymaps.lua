--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>qq", ":qall<CR>", { desc = "Quit Session" })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Toggle Neotree in current directory and reveal current file
vim.keymap.set("n", "\\", ":Neotree toggle current reveal_force_cwd<CR>", {
  desc = "Toggle Neotree (current dir, reveal file)",
  silent = true,
  noremap = true,
})

-- Reveal current file in Neotree
vim.keymap.set("n", "|", ":Neotree reveal<CR>", {
  desc = "Reveal current file in Neotree",
  silent = true,
  noremap = true,
})

-- yank no longer replaces any overwtitten text in the register
vim.keymap.set("x", "p", "P", { silent = true })
