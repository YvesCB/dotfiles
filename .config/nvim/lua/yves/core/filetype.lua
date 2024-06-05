-- Setting up filetype specific things

-- Automatically set the line wrap and spell but only in pure text files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	desc = "Set wordwrap and spell when in 'txt', 'md' or 'tex' files.",
	group = vim.api.nvim_create_augroup("linewrap-in-text-files", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
		vim.cmd("setlocal spell")
	end,
})
