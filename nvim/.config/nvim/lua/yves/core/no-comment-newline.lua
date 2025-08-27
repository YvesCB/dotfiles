-- Set up autocmd to make neovim no longer auto comment a new line after a comment
vim.api.nvim_create_autocmd("FileType", {
	desc = "Change nvim behavior to not add comments automatically on new line after existing comment",
	pattern = "*",
	group = vim.api.nvim_create_augroup("no-comment-newline", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove("c")
		vim.opt.formatoptions:remove("r")
		vim.opt.formatoptions:remove("o")
	end,
})
