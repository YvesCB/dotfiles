-- Setting up filetype specific things

-- Automatically set the line wrap and spell but only in pure text files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "markdown", "tex", "typst" },
  desc = "Set wordwrap and spell when in 'txt', 'md', 'tex' or 'typst' files.",
  group = vim.api.nvim_create_augroup("linewrap-in-text-files", { clear = true }),
  callback = function()
    vim.bo.wrap = true
    vim.cmd("setlocal spell")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp", "rust", "toml", "make", "json" },
  desc = "Use 4-space indentation for C, C++, Rust, TOML, MAKE, JSON",
  group = vim.api.nvim_create_augroup("indent-4-space", { clear = true }),
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
  end,
})
