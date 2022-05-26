return {
  prettier = vim.fn.executable("prettier") == 1,
  eslint = vim.fn.executable("eslint") == 1,
}
