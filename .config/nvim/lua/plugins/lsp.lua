return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        ts_ls = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        svelte = {},
        lua_ls = {},
        graphql = {},
        emmet_ls = {},
        prismals = {},
        pyright = {},
        clangd = {},
      },
    },
  },
}
