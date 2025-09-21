local M = {}

-- @class (exact) TSAConfig
-- @field ignore string[]
local config = {
	ignore = {}
}

local nvim_treesitter = require("nvim-treesitter")

function detected_ft_cb(opts)
	local ft = opts.match
	if vim.list_contains(config.ignore, ft) then return end
	nvim_treesitter.install(ft)
end

-- @param user_config TSAConfig
function M.setup(user_config)
	if user_config then
		config.ignore = user_config.ignore or {}
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("TreesitterAutoinstallPlugin", { clear = true }),
		callback = detected_ft_cb
	})
end

return M
