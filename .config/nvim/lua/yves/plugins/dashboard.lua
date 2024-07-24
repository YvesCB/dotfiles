return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			-- config
			theme = "hyper", --  theme is doom and hyper default is hyper
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
