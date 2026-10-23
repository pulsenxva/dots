--return {
--  {
--    "navarasu/onedark.nvim",
--    priority = 1000,
--    config = function()
--      require("onedark").setup({
--        style = "dark",
--        transparent = true,
--      })
--      require("onedark").load()
--    end,
--  },
--}
return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,

    config = function()
      -- Dark theme
      vim.o.background = "dark"

      -- Gruvbox Material settings
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"

      -- 2 = transparent background + more UI elements
      vim.g.gruvbox_material_transparent_background = 2

      -- Optional
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd.colorscheme("gruvbox-material")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}

