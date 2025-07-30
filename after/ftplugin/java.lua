local set = vim.opt_local
set.shiftwidth = 4
set.number = true
set.relativenumber = true
vim.keymap.set("n", "<leader>r", "<cmd>split | term java %<CR>")
