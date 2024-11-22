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
        Boolean = { fg = colors.magenta },
        Changed = { fg = colors.yellow },
        Comment = { fg = colors.base01, italic = true },
        Constant = { fg = colors.yellow },
        Define = { fg = colors.green, bold = false },
        ExtraWhitespace = { bg = colors.red },
        Identifier = { fg = colors.base0 },
        IncSearch = { bg = colors.red, fg = colors.base02, bold = false },
        Keyword = { fg = colors.green, bold = false },
        Normal = { fg = colors.base0 },
        NormalFloat = { bg = colors.base02, fg = colors.base00  },
        Number = { fg = colors.magenta },
        PreProc = { fg = colors.orange },
        Property = { fg = colors.base0 },
        Search = { bg = colors.yellow, fg = colors.base02, bold = false },
        SignColumn = { bg = colors.base02 },
        PmenuSel = { fg = colors.base0, bg = colors.base2 },

        -- FzfLua
        FzfLuaBorder = { link = 'Normal' },
        FzfLuaBufFlagAlt = { link = 'Normal' },
        FzfLuaBufFlagCur = { link = 'Normal' },
        FzfLuaBufName = { link = 'Normal' },
        FzfLuaBufNr = { link = 'Special' },
--        FzfLuaCursor = { link = 'Normal' },
--        FzfLuaCursorLine = { link = 'Normal' },
--        FzfLuaCursorLineNr = { link = 'Normal' },
        FzfLuaDirIcon = { link = 'Normal' },
        FzfLuaDirPart = { link = 'Normal' },
        FzfLuaFilePart = { link = 'Normal' },
        FzfLuaFzfBorder = { link = 'Normal' },
        FzfLuaFzfCursorLine = { link = 'Normal' },
        FzfLuaFzfGutter = { link = 'Normal' },
        FzfLuaFzfHeader = { link = 'Normal' },
        FzfLuaFzfInfo = { link = 'Normal' },
        FzfLuaFzfMarker = { link = 'Normal' },
        FzfLuaFzfMatch = { link = 'Normal' },
        FzfLuaFzfNormal = { link = 'Normal' },
        FzfLuaFzfPointer = { link = 'Normal' },
        FzfLuaFzfPrompt = { link = 'Normal' },
        FzfLuaFzfQuery = { link = 'Normal' },
        FzfLuaFzfScrollbar = { link = 'Normal' },
        FzfLuaFzfSeparator = { link = 'Normal' },
        FzfLuaFzfSpinner = { link = 'Normal' },
        FzfLuaHeaderBind = { link = 'Comment' },
        FzfLuaHeaderText = { link = 'Comment' },
        FzfLuaHelpBorder = { link = 'Normal' },
        FzfLuaHelpNormal = { link = 'Normal' },
        FzfLuaLiveSym = { link = 'Normal' },
        FzfLuaNormal = { link = 'Normal' },
        FzfLuaPathColNr = { link = 'Normal' },
        FzfLuaPathLineNr = { link = 'Normal' },
        FzfLuaPreviewBorder = { link = 'Normal' },
        FzfLuaPreviewNormal = { link = 'Normal' },
        FzfLuaPreviewTitle = { link = 'Normal' },
        FzfLuaScrollBorderEmpty = { link = 'Normal' },
        FzfLuaScrollBorderFull = { link = 'Normal' },
        FzfLuaScrollFloatEmpty = { link = 'Normal' },
        FzfLuaScrollFloatFull = { link = 'Normal' },
        FzfLuaSearch = { link = 'Normal' },
        FzfLuaTabMarker = { link = 'Normal' },
        FzfLuaTabTitle = { link = 'Normal' },
        FzfLuaTitle = { link = 'Normal' },

        -- Coc
        CocMarkdownLink = { fg = colors.base0 },
        CocMenuSel = { fg = colors.base0, bg = colors.base2 },
        CocSearch = { fg = colors.base0 },

        -- Signify
        SignifyLineAdd = { fg = colors.green, bg = colors.base02 },
        SignifyLineChange = { fg = colors.diag_warning, bg = colors.base02 },
        SignifyLineDelete = { fg = colors.orange, bg = colors.base02 },
        SignifySignAdd = { fg = colors.green, bg = colors.base02 },
        SignifySignChange = { fg = colors.diag_warning, bg = colors.base02 },
        SignifySignDelete = { fg = colors.orange, bg = colors.base02 },

        -- ruby
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

        -- treesitter
        ['@keyword.function.lua'] = { fg = colors.green },
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
