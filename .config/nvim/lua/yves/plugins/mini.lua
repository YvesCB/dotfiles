-- Collection of various small independent plugins/modules
return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- NOTE: Using nvim-surround instead
		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		-- require("mini.surround").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		statusline.setup()

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		require("mini.pairs").setup()

		-- local MiniFiles = require("mini.files")
		-- MiniFiles.setup()
		-- local minifiles_toggle = function()
		-- 	if not MiniFiles.close() then
		-- 		MiniFiles.open()
		-- 	end
		-- end
		-- vim.keymap.set("n", "-", function()
		-- 	minifiles_toggle()
		-- end, { silent = true, desc = "Open up mini.files" })

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
