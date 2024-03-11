return {
	"rrethy/vim-hexokinase",
	build = "make hexokinase",
	lazy = true,
	config = function()
		require("vim-hexokinase").setup()
		vim.keymap.set(
			"n",
			"<leader>tc",
			":HexokinaseToggle <cr>",
			{ silent = true, desc = "[T]oggle [C]olorpreviw (with hexokinase)" }
		)
	end,
}
