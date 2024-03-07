return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		config = function()
			local todo = require("todo-comments")
			vim.keymap.set("n", "]t", function()
				todo.jump_next()
			end, { desc = "Jump to next TODO item" })
			vim.keymap.set("n", "[t", function()
				todo.jump_previous()
			end, { desc = "Jump to previous TODO item" })
		end,
	},
}
