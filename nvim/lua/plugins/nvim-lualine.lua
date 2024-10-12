function trailing_whitespaces()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TW:"..space or ""
end

return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  config = function()
    local colors = require('colors.solarized')

    local custom_fname = require('lualine.components.filename'):extend()
    local highlight = require('lualine.highlight')

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
            a = { bg = colors.mix_blue, fg = colors.base3 },
            b = { bg = colors.base2, fg = colors.base3 },
            c = { bg = colors.base02, fg = colors.gray },
            x = { bg = colors.base02, fg = colors.base2 }
          },
          insert = { a = { bg = colors.diag_warning, fg = colors.base3 }, },
          visual = { a = { bg = colors.dark_magenta, fg = colors.base3 }, },
          replace = { a = { bg = colors.red, fg = colors.base3 }, },
        },
        icons_enabled = true,
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''}
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diagnostics' },
        lualine_c = { { custom_fname, path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = {
          function()
            local encoding = vim.bo.fileencoding or vim.o.encoding
            local fileformat = vim.bo.fileformat
            return string.format('%s[%s]', encoding, fileformat)
          end
        },
        lualine_z = {
          {
            -- show line_nr:col_nr progress% [total_lines]
            function()
              local line = vim.fn.line('.')
              local col = vim.fn.col('.')
              local total_lines = vim.fn.line('$')
              local percent = math.floor((line / total_lines) * 100)
              return string.format('%3d:%-2d %1d%%%% [%d]', line, col, percent, total_lines)
            end
          },
          {
            -- show trailing whitespace
            color = { bg = colors.red },
            function()
              if vim.api.nvim_get_mode().mode == 'n' then
                local space = vim.fn.search([[\s\+$]], 'nwc')
                return space ~= 0 and string.format('☲ [%s] trailing', space) or ''
              else
                return ''
              end
            end
          }
        }
      },
    })
  end
}
