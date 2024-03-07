return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
		config = function()
			local todo = require("todo-comments")
			vim.keymap.set("n", "]t", todo.jump_next(), { desc = "Jump to next TODO item" })
			vim.keymap.set("n", "[t", todo.jump_previous(), { desc = "Jump to previous TODO item" })
		end,
	},
}
