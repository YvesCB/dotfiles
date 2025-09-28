local mason_cmd = vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver"
local system_cmd = vim.fn.exepath("pyright-langserver") -- if installed globally

local cmd = nil
if vim.fn.filereadable(mason_cmd) == 1 then
  cmd = mason_cmd
elseif system_cmd ~= "" then
  cmd = system_cmd
end

return {
  -- Give Neovim an explicit command to run:
  cmd = { cmd, "--stdio" },

  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        autoImportCompletions = true,
      },
    },
  },
}
