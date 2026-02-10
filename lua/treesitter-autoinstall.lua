local M = {}

---@class (exact) TSAConfig
---@field ignore? string[] Filetypes to ignore when auto installing
---@field highlight? boolean Whether to highlight installed filetypes
---@field regex? string[] Filetypes to also highlight with regex
local config = {
	ignore = {},
	highlight = true,
	regex = {},
}

local nvim_treesitter = require("nvim-treesitter")

local function enable_highlight(ft, bufnr)
	vim.treesitter.start(bufnr)
	if vim.list_contains(config.regex, ft) then
		vim.bo[bufnr].syntax = "on"
	end
end

local function detected_ft_cb(args)
	local bufnr = args.buf
	local ft = args.match
	local lang = vim.treesitter.language.get_lang(ft)

	if vim.list_contains(config.ignore, ft) then
		return
	end

	if lang == ft and not vim.list_contains(nvim_treesitter.get_available(), ft) then
		return
	end

	nvim_treesitter.install(lang):await(function()
		if not vim.api.nvim_buf_is_loaded(bufnr) then
			return
		end

		if config.highlight then
			local installed = nvim_treesitter.get_installed()

			if vim.list_contains(installed, ft) then
				enable_highlight(ft, bufnr)
			end
		end
	end)
end

---@param user_config? TSAConfig
function M.setup(user_config)
	local config_keys = vim.tbl_keys(config)
	if user_config then
		for k, v in pairs(user_config) do
			assert(vim.list_contains(config_keys, k),
				"Key '" .. k .. "' is not supported in plugin's configuration")

			config[k] = v
		end
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("TreesitterAutoinstallPlugin", {
			clear = true
		}),
		callback = detected_ft_cb
	})
end

return M
