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
      normal = true,          -- Main editor window background
      normalfloat = true,     -- Floating windows
      neotree = true,         -- Neo-tree file explorer
      nvimtree = true,        -- Nvim-tree file explorer
      whichkey = true,        -- Which-key popup
      telescope = true,       -- Telescope fuzzy finder
      lazy = true,            -- Lazy plugin manager UI
      mason = true,           -- Mason manage external tooling
    },
    on_colors = function()
      return require('colors.skolarized')
    end,
    on_highlights = function(colors, _)
      return {
        -- EndOfBuffer = { fg = colors.magenta },
        AlphaHeader = { fg = colors.mix_base1 },
        AlphaHeaderLabel = { fg = colors.violet },
        Keyword = { fg = colors.green },
        PreProc = { fg = colors.orange },
        Boolean = { fg = colors.magenta },
        Changed = { fg = colors.yellow },
        Comment = { fg = colors.base01, italic = true },
        Constant = { fg = colors.yellow },
        Define = { fg = colors.green, bold = false },
        ExtraWhitespace = { bg = colors.red },
        Identifier = { fg = colors.base0 },
        IncSearch = { bg = colors.red, fg = colors.base02, bold = false },
        Normal = { fg = colors.base0 },
        Number = { fg = colors.magenta },
        Property = { fg = colors.base0 },
        Search = { bg = colors.yellow, fg = colors.base02, bold = false },
        rubyConstant = { fg = colors.yellow },
        rubyFloat = { fg = colors.magenta },
        rubyInstanceVariable = { link = 'Directory' },
        rubyInteger = { fg = colors.magenta },
        rubyMacro = { fg = colors.orange },
        rubyMagicComment = { fg = colors.orange },
        rubyPercentStringDelimiter = { fg = colors.violet },
        rubyString = { fg = colors.green },
        rubyStringDelimiter = { fg = colors.green },
        rubySymbol = { fg = colors.cyan },
        NormalFloat = { bg = colors.base02, fg = colors.base00  },
        ['@keyword.function.lua'] = { fg = colors.green },
        CocMenuSel = { fg = colors.base0, bg = colors.base2 },
        CocSearch = { fg = colors.base0 },
        CocMarkdownLink = { fg = colors.base0 },
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
