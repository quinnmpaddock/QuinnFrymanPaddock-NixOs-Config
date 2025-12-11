return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          -- Disable for vim command window if it's causing issues
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          if buftype == 'nofile' or buftype == 'prompt' then
            return true
          end
          return false
        end,
      },
      indent = { enable = true },
    },
  },
}
