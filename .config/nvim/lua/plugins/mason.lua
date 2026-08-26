return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        "biome",
        "stylua",
        "isort",
        "black",
        "clang-format",
        "pylint",
        "eslint_d",
      },
    },
  },
}
