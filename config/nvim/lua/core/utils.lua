local reg = require("mason-registry")
local path = require("mason-core.path")
local M = {}

function M.map(modes, lhs, rhs, opts)
	opts = opts or {}
	opts.noremap = opts.noremap == nil and true or opts.noremap
	if type(modes) == "string" then
		modes = { modes }
	end
	for _, mode in ipairs(modes) do
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

function M.highlight(group, bg, fg, gui)
	if gui ~= nil and gui ~= "" then
		vim.api.nvim_command(string.format("hi %s guibg=%s guifg=%s gui=%s", group, bg, fg, gui))
	else
		vim.api.nvim_command(string.format("hi %s guibg=%s guifg=%s", group, bg, fg))
	end
end

function M.mason_get_path(package_name)
	return path.concat({ vim.fn.stdpath("data"), "mason", "bin", package_name })
end

function M.mason_ensure_tools(packages)
	for _, package in ipairs(packages) do
		local p = reg.get_package(package["name"])

		if not p:is_installed() then
			print("Installing " .. package["name"])
			p:install({ version = package["version"] })
		end
	end
end

return M
