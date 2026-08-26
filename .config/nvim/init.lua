-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>")
vim.opt.clipboard = "unnamedplus"
