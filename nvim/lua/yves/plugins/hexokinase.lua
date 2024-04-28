return {
	"rrethy/vim-hexokinase",
	build = "make hexokinase",
	init = function()
		vim.g.Hexokinase_highlighters = { "backgroundfull" }
	end,
	config = function()
		vim.keymap.set(
			"n",
			"<leader>tx",
			":HexokinaseToggle <cr>",
			{ silent = true, desc = "[T]oggle colorpreviw (with He[x]okinase)" }
		)
		-- NOTE: This isn't working becuase I need to find out how and when hexo reads the
		--
		-- variable and what to refresh. If it's even possible
		-- vim.keymap.set("n", "<leader>tcs", function()
		-- 	if cur_hl == 1 then
		-- 		cur_hl = 2
		-- 		vim.g.Hexokinase_highlighters = { "backgroundfull" }
		-- 	else
		-- 		cur_hl = 1
		-- 		vim.g.Hexokinase_highlighters = { "virtual" }
		-- 	end
		-- end, { silent = true, desc = "[T]oggle [C]olorpreviw [S]tyle (with hexokinase)" })
	end,
}
