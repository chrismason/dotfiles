return {
  prettier = vim.fn.executable("prettier") == 1,
  eslint_d = vim.fn.executable("eslint_d") == 1,
}
