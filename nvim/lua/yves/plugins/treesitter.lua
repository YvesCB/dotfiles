-- Highlight, edit, and navigate code
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"nvim-treesitter/nvim-treesitter",
		dependancies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			require("nvim-treesitter.configs").setup({
				modules = { "" },
				sync_install = false,
				ignore_install = { "" },
				ensure_installed = {
					"rust",
					"java",
					"bash",
					"c",
					"cpp",
					"c_sharp",
					"html",
					"lua",
					"markdown",
					"sql",
					"vim",
					"vimdoc",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				-- There are additional nvim-treesitter modules that you can use to interact
				-- with nvim-treesitter. You should go explore a few and see what interests you:
				--
				--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
				--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
				--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.outer",
						},
					},
				},
			})
		end,
	},
}
