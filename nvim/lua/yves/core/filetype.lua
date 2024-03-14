-- Setting up filetype specific things

-- Automatically set the line wrap but only in pure text files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.txt", "*.md", "*.tex" },
	desc = "Set wordwrap when in 'txt', 'md' or 'tex' files",
	group = vim.api.nvim_create_augroup("linewrap-in-text-files", { clear = true }),
	callback = function()
		vim.opt_local.wrap = true
	end,
})
