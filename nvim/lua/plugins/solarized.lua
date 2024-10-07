-- Solarized colorscheme
return {
  'maxmx03/solarized.nvim',
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    transparent = {
      enabled = true,         -- Master switch to enable transparency
      pmenu = true,           -- Popup menu (e.g., autocomplete suggestions)
      normal = false,          -- Main editor window background
      normalfloat = true,     -- Floating windows
      neotree = true,         -- Neo-tree file explorer
      nvimtree = true,        -- Nvim-tree file explorer
      whichkey = true,        -- Which-key popup
      telescope = true,       -- Telescope fuzzy finder
      lazy = true,            -- Lazy plugin manager UI
      mason = true,           -- Mason manage external tooling
    },
    on_colors = function()
      return require('colors.solarized')
    end,
    on_highlights = function(colors, color)
      local lighten = color.lighten

      return {
        -- EndOfBuffer = { fg = colors.magenta },
        AlphaHeader = { fg = colors.mix_base1 },
        AlphaHeaderLabel = { fg = colors.violet },
        Boolean = { fg = colors.magenta },
        Changed = { fg = colors.yellow },
        Comment = { italic = true },
        Define = { fg = colors.green, bold = false },
        Identifier = { fg = colors.base0 },
        IncSearch = { bg = colors.red, fg = colors.base02, bold = false },
        Normal = { fg = colors.base0 },
        Number = { fg = colors.magenta },
        Property = { fg = colors.base0 },
        Search = { bg = colors.yellow, fg = colors.base02, bold = false },
        Type = { fg = colors.yellow },
        rubyFloat = { link = Number },
        rubyInteger = { link = Number },
        rubyMacro = { fg = colors.orange },
        rubyMagicComment = { fg = colors.orange },
        rubyPercentStringDelimiter = { fg = colors.violet },
        rubyString = { fg = colors.green },
        rubyStringDelimiter = { fg = colors.green },
        rubySymbol = { fg = colors.cyan },
        rubyConditional = { fg = colors.violet },
        ExtraWhitespace = { bg = colors.red }
      }
    end
  },

  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup(opts)
    vim.cmd.colorscheme 'solarized'
  end
}
