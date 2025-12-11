require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",  -- or "anthropic", "ollama", etc.
    },
    inline = {
      adapter = "ollama",
    },
    agent = {
      adapter = "ollama",
    },
  },
  adapters = { 
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
				schema = {
          model = {
            default = "gemma3:12b",
				  },
        },
				  endpoint = {
						default = "http://localhost:11434",  -- Environment variable name
        },
      })
    end,
  },
})

-- Optional: Set up keymaps
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
