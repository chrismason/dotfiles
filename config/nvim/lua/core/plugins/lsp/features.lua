return {
  prettier = vim.fn.executable("prettier") == 1,
  eslint_d = vim.fn.executable("eslint_d") == 1,
  rubocop = vim.fn.executable("bin/rubocop") == 1,
  solargraph = vim.fn.executable("bin/solargraph") == 1,
  sorbet = vim.fn.executable("bin/sorbet") == 1,
}
