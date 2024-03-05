return {
	"ggandor/leap.nvim",
	dependancies = {
		"tpope/vim-repeat",
	},
	config = function()
		require("leap").add_default_mappings()
	end,
}
