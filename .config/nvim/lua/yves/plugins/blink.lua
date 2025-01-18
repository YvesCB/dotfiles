return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",

	version = "*",

	opts = {
		keymap = {
			preset = "default",

			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			-- use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true, window = { border = "single" } },
		completion = {
			menu = { border = "single" },
			documentation = { window = { border = "single" } },
			list = {
				-- Maximum number of items to display
				max_items = 200,

				selection = "preselect",
			},
		},
	},
	opts_extend = { "sources.default" },
}
