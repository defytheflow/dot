require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "typescript",
    "python",
    "tsx",
    "json",
    "bash",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
  },

  context_commentstring = {
    enable = true,
  },

  autotag = {
    enable = true,
  },
}

require("treesitter-context").setup {
  on_attach = function()
    vim.keymap.set("n", "<leader>ct", function()
      vim.cmd.TSContextToggle()
    end, { desc = "[C]ontext [T]oggle" })

    vim.keymap.set("n", "<leader>cg", function()
      require("treesitter-context").go_to_context()
    end, { desc = "[C]ontext [G]o" })
  end
}
