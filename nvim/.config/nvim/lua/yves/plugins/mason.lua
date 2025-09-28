return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      -- Mason adds its bin dir to PATH (so vim.lsp.enable finds the binaries)
      PATH = "prepend", -- or "append" if you prefer system tools first
      ui = { border = "single" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- install/update tools on start
    opts = {
      ensure_installed = {
        -- LSP servers (Mason package names, not client names)
        "lua-language-server",
        "rust-analyzer",
        "clangd",
        "typescript-language-server",
        "svelte-language-server",
        "tailwindcss-language-server",
        "tinymist",
      },
      auto_update = false, -- set true if you want silent updates
      run_on_start = true,
      start_delay = 3000,  -- ms after startup before installing
      debounce_hours = 24,
    },
    dependencies = { "williamboman/mason.nvim" },
  },
}
