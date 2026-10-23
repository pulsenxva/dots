return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "horizontal",
      size = 15,
      start_in_insert = true,
      persist_size = true,
      close_on_exit = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-`>]],
      direction = "horizontal",
      size = 15,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "horizontal",
      size = 15,
      start_in_insert = true,
      persist_size = true,
      close_on_exit = false,

      dir = function()
        return vim.fn.expand("%:p:h")
      end,
    },
  },
}
