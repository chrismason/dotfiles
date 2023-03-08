return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      require("plugins.lsp.config")
      require("plugins.lsp.mason-lspconfig")
    end
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp.null-ls")
    end
  }
}
