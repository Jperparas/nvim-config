local set = vim.opt_local
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.number = true
set.relativenumber = true

-- Key mappings for TypeScript/React development
vim.keymap.set("n", "<leader>r", "<cmd>split | term npm run dev<CR>", { buffer = true })
vim.keymap.set("n", "<leader>t", "<cmd>split | term npm test<CR>", { buffer = true })
vim.keymap.set("n", "<leader>b", "<cmd>split | term npm run build<CR>", { buffer = true })
