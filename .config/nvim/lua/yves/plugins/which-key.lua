-- Useful plugin to show you pending keybinds.
return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VimEnter'
	opts = {
		-- NOTE: leaving empty to keep defaults
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>c_", hidden = true },
		{ "<leader>d", group = "[D]ocument" },
		{ "<leader>d_", hidden = true },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>r_", hidden = true },
		{ "<leader>s", group = "[S]earch and [S]pellcheck" },
		{ "<leader>s_", hidden = true },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>t_", hidden = true },
		{ "<leader>w", group = "[W]orkspace" },
		{ "<leader>w_", hidden = true },
		{ "<leader>d", group = "[D]AP" },
		{ "<leader>d_", hidden = true },
	},
	-- config = function() -- This is the function that runs, AFTER loading
	-- 	require("which-key").setup()
	--
	-- 	-- Document existing key chains
	-- 	require("which-key").register({
	-- 		["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
	-- 		["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
	-- 		["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
	-- 		["<leader>s"] = { name = "[S]earch and [S]pellcheck", _ = "which_key_ignore" },
	-- 		["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
	-- 		["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
	-- 	})
	-- end,
}
