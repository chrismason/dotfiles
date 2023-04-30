return {
    prettier = vim.fn.executable("prettier") == 1,
    eslint = vim.fn.executable("eslint") == 1,
    golangci_lint = vim.fn.executable("golangci-lint") == 1,
    rubocop = vim.fn.executable("rubocop") == 1,
    solargraph = vim.fn.executable("solargraph") == 1,
    sorbet = vim.fn.executable("srb") == 1,
    stylua = vim.fn.executable("stylua") == 1,
    tsc = vim.fn.executable("tsc") == 1,
    rustfmt = vim.fn.executable("rustfmt") == 1,
    terraform = vim.fn.executable("terraform") == 1,
}
