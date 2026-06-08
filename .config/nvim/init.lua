vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2  
vim.opt.expandtab = true 

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
  
  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = { "clangd", "ts_ls", "pyright", "gopls" }
      
      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          spacing = 8,
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
        signs = false,
        update_in_insert = false,
      })
      
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = {
            spacing = 8,
            min = vim.diagnostic.severity.ERROR,
          },
          signs = false,
          update_in_insert = false,
        }
      )
      
      local lsp_on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      end
      
      for _, lsp in ipairs(servers) do
        require('lspconfig')[lsp].setup({
          on_attach = lsp_on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
        })
      end
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", 
    },
  },
  
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- dashboard stuff
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#5eead4" })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#8b5cf6" })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#c084fc" })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f0abfc" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#f9a8d4" })

vim.o.laststatus = 3

-- set line number colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#737373", bold = false })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#737373", bold = false })

require("notify").setup({
  background_colour = "#0a0a0a",
  stages = "fade_in_slide_out",
  timeout = 5000,
  render = "compact",
})

require("oil").setup()
vim.o.title = true
vim.o.titlestring = "%f"

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
  end,
})
