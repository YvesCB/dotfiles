-- CUSTOM KEYMAPS
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local os = vim.loop.os_uname().sysname
local termcommand = ':term pwsh <cr>i'
local termsplit = ':botright :15 split <cr>'

-- Spellcheck
vim.keymap.set('n', '<leader>sy', ':setlocal spell<cr>', { silent = true, desc = '[S]pellcheck [Y]es' })
vim.keymap.set('n', '<leader>sn', ':set nospell<cr>', { silent = true, desc = '[S]spellcheck [N]o' })

if os == "Linux" then
  termcommand = ':term zsh <cr> i clear <cr>'
end

-- Opening and closing terminals
vim.keymap.set('n', '<leader>ot', termsplit .. termcommand, { silent = true, desc = 'Open pwsh Terminal' })
vim.keymap.set('t', '<c-q>', '<c-\\><c-n> :q <cr>', { silent = true, desc = 'Close terminal' })

-- Window resizig
vim.keymap.set('n', '<a-h>', ':vert :res +5<cr>', { silent = true, desc = 'Decrease width' })
vim.keymap.set('n', '<a-k>', ':res -5<cr>', { silent = true, desc = 'Increase height' })
vim.keymap.set('n', '<a-j>', ':res +5<cr>', { silent = true, desc = 'Decrease height' })
vim.keymap.set('n', '<a-l>', ':vert :res -5<cr>', { silent = true, desc = 'Increase width' })

-- Navigating half screens
vim.keymap.set('n', '<c-d>', '<c-d>zz', { silent = true })
vim.keymap.set('n', '<c-u>', '<c-u>zz', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Open netrw
vim.keymap.set('n', '<leader>ft', ':e . <cr>', { desc = 'Open diagnostic [Q]uickfix list' })
