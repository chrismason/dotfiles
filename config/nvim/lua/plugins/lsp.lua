local function on_attach()
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

require'lspconfig'.yamlls.setup{}

require'lspconfig'.gopls.setup{
     on_attach=on_attach,
     cmd = {"gopls", "serve"},
     settings = {
         gopls = {
	      analyses = {
	           unusedparams = true,
              },
	      staticcheck = true,
         },
     },
}
