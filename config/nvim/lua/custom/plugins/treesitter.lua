return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "css",
        "c_sharp",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "ruby",
        "rust",
        "scss",
        "terraform", 
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = opts.ensure_installed
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  }
}