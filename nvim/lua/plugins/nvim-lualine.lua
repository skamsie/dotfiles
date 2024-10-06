function trailing_whitespaces()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TW:"..space or ""
end

return {
  'nvim-lualine/lualine.nvim',
  enabled = false,
  config = function()
    colors = require('solarized.palette')

    require('lualine').setup({
      options = {
        theme = {
          normal = {
            a = { bg = colors.solarized.base02, fg = colors.solarized.base01 },
          },
          insert = {
            a = { bg = colors.solarized.base03, fg = colors.solarized.base01 },
          },
        },
        icons_enabled = true,
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '|', right = '|'}
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
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end
}
