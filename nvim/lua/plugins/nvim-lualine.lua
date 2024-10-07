--function trailing_whitespaces()
  --  local space = vim.fn.search([[\s\+$]], 'nwc')
  --  return space ~= 0 and "TW:"..space or ""
  --end

return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  config = function()
    local colors = require('colors.solarized')

    local custom_fname = require('lualine.components.filename'):extend()
    local highlight = require'lualine.highlight'
    local default_status_colors = { saved = '#228B22', modified = '#C70039' }

    function custom_fname:init(options)
      custom_fname.super.init(self, options)
      self.status_colors = {
        saved = highlight.create_component_highlight_group(
        { fg = colors.base2 }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
        { fg = colors.red }, 'filename_status_modified', self.options),
      }
      if self.options.color == nil then self.options.color = '' end
    end

    function custom_fname:update_status()
      local data = custom_fname.super.update_status(self)
      data = highlight.component_format_highlight(vim.bo.modified
      and self.status_colors.modified
      or self.status_colors.saved) .. data
      return data
    end

    require('lualine').setup({
      options = {
        theme = {
          normal = {
            a = { bg = colors.mix_blue, fg = colors.base0, gui = 'bold' },
            b = { bg = colors.mix_base1, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.gray }
          },
          insert = {
            a = { bg = colors.mix_yellow, fg = colors.base0, gui = 'bold' },
            b = { bg = colors.mix_base1, fg = colors.base1 },
            c = { bg = colors.base02, fg = colors.gray }
          },
        },
        icons_enabled = true,
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        --        lualine_b = { 'diff',
        --            { 'diagnostics', sources = { 'nvim_lsp', 'nvim_diagnostic' } },
        --            function()
          --                local space = vim.fn.search([[\s\+$]], 'nwc')
          --                return space ~= 0 and "trailing:" .. space or ""
          --            end },
          lualine_c = { { custom_fname, path = 1 } },
          lualine_x = { 'encoding', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
    })
  end
}
