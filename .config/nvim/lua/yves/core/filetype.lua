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

-- Automatically set the shiftwidth and tabstop for web things
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.html", "*.css", "*.js", "*.ts", "*.svelte", "*.jsx", "*.tsx" },
	desc = "Set the tabstop and shiftwidth to 2 for web dev files.",
	group = vim.api.nvim_create_augroup("tabstop-and-shiftwidth-for-web-dev", { clear = true }),
	callback = function()
		vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default is 2)
		vim.o.shiftwidth = 2 -- 2 spaces for indent width
	end,
})
