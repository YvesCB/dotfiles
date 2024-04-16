-- [[ Setting options ]]
-- See `:help vim.o`

-- CUSTOM SETTINGS:
-- tabs & indentation
vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 2 -- 2 spaces for indent width
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one

-- scrolloff, keep at least 10 lines visible bellow the cursor
vim.o.scrolloff = 10

-- vim.o.winbar = '%f'
vim.o.splitbelow = true
vim.o.splitright = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.wrap = false

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Set conceal level for markdown stuff
vim.o.conceallevel = 2

-- NOTE: Spellcheck
vim.o.spelllang = "en,de_ch"

-- NOTE: Defining globals
--
-- Netrw configs
vim.g.netrw_banner = 0 -- disable annoying banner
vim.g.netrw_winsize = 30 -- netrw in 30% window
vim.g.netrw_browse_split = 0 -- control how files are opened
vim.g.netrw_altv = 1 -- open splits to the right
vim.g.netrw_alto = 0 -- open splits on the bottom
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_localcopydircmd = "cp -r" -- enable recursive copy of dirs
vim.g.netrw_preview = 1 -- preview window in vertical split
