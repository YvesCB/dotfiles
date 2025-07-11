-- CUSTOM KEYMAPS
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local os = vim.loop.os_uname().sysname
local termcommand = ":term pwsh <cr>i"
local termsplit = ":botright :15 split <cr>"

if os == "Linux" then
  termcommand = ":term zsh <cr> i clear <cr>"
end

-- Opening and closing terminals
vim.keymap.set("t", "<c-q>", "<c-\\><c-n> :q <cr>", { silent = true, desc = "Close terminal" })

-- Window resizig
vim.keymap.set("n", "<M-,>", "<c-w>5<", { silent = true, desc = "Decrease split width" })
vim.keymap.set("n", "<M-.>", "<c-w>5>", { silent = true, desc = "Increase split width" })
vim.keymap.set("n", "<M-u>", "<c-w>+", { silent = true, desc = "Increase split height" })
vim.keymap.set("n", "<M-d>", "<c-w>-", { silent = true, desc = "Decrease split height" })

-- Navigating half screens
vim.keymap.set("n", "<c-d>", "<c-d>zz", { silent = true })
vim.keymap.set("n", "<c-u>", "<c-u>zz", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Open netrw
vim.keymap.set("n", "<leader>ft", ":Lexplore <cr>", { desc = "Open diagnostic [Q]uickfix list" })

-- Toggles
local toggle_spell = function()
  if vim.o.spell then
    vim.cmd("set nospell")
  else
    vim.cmd("setlocal spell")
  end
end

local toggle_color_col = function()
  if vim.o.cc == "" then
    vim.o.cc = "80"
  else
    vim.o.cc = ""
  end
end

vim.keymap.set("n", "<leader>ts", toggle_spell, { silent = true, desc = "[T]oggle [S]pellcheck" })

vim.keymap.set("n", "<leader>tt", termsplit .. termcommand, { silent = true, desc = "[T]oggle [T]erminal" })
vim.keymap.set("n", "<leader>tc", toggle_color_col, { silent = true, desc = "[T]oggle [C]olorcolumn at 80" })

-- Quickfixstuff
vim.keymap.set("n", "<leader>q", ":copen <cr>", { silent = true, desc = "Open [Q]uickfix list" })
vim.keymap.set("n", "<leader>qq", ":cclose <cr>", { silent = true, desc = "[C]lose [Q]uickfix list" })
vim.keymap.set("n", "<leader>qn", ":cn <cr>", { silent = true, desc = "[N]ext [Q]uickfix item" })
vim.keymap.set("n", "<leader>qp", ":cp <cr>", { silent = true, desc = "[P]revious [Q]uickfix item" })
