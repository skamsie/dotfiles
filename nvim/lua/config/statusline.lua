local colors = require('colors.skolarized')
local cmp = {} -- statusline components

local bg_color = colors.base02

vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.base01, bg = bg_color })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = bg_color, fg = colors.base2 })

vim.api.nvim_set_hl(0, 'StatusLineNormal', { fg = bg_color, bg = colors.base0 })
vim.api.nvim_set_hl(0, 'StatusLineCommand', { fg = bg_color, bg = colors.violet })
vim.api.nvim_set_hl(0, 'StatusLineInsert', { fg = bg_color, bg = colors.diag_warning })
vim.api.nvim_set_hl(0, 'StatusLineVisual', { fg = bg_color, bg = colors.magenta })
vim.api.nvim_set_hl(0, 'StatusLineTerminal', { fg = bg_color, bg = colors.base2 })
vim.api.nvim_set_hl(0, 'StatusLineReplace', { fg = bg_color, bg = colors.red })
vim.api.nvim_set_hl(0, 'StatusLineFNameModified', { fg = colors.red, bg = bg_color })
vim.api.nvim_set_hl(0, 'StatusLineFName', { fg = colors.base01, bg = bg_color })
vim.api.nvim_set_hl(0, 'StatusLineTrailing', { fg = colors.base0, bg = colors.red })
vim.api.nvim_set_hl(0, 'StatusLineInactive', { link = 'StatusLineNC' })

-- Highlight pattern
local hi_pattern = '%%#%s#%s%%*'

local mode_map = {
  n      = { name = '󰰓 ', hl = 'StatusLineNormal' },
  i      = { name = '󰰄 ', hl = 'StatusLineInsert' },
  v      = { name = '󰰫 ', hl = 'StatusLineVisual' },
  c      = { name = '󰯲 ', hl = 'StatusLineCommand' },
  V      = { name = '󰰫 ', hl = 'StatusLineVisual' },
  [''] = { name = '󰰫 ', hl = 'StatusLineVisual' },
  R      = { name = '󰰟 ', hl = 'StatusLineReplace'},
  t      = { name = '󰰥 ', hl = 'StatusLineTerminal'},
}

function _G._statusline_component(name)
  return cmp[name]()
end

-- Function to get the current mode with color
function cmp.mode_status()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = mode_map[current_mode] or { name = current_mode, hl = 'StatusLineDefault' }

  -- Return formatted mode with colors
  return hi_pattern:format(mode_info.hl, ' ' .. mode_info.name .. ' ')
end

-- Function to show the filename with modified status
function cmp.filename_active()
  local filepath = vim.fn.expand('%:p') -- Get the full path of the current file
  local home = os.getenv('HOME')
  if filepath:sub(1, #home) == home then
    filepath = '~' .. filepath:sub(#home + 1)
  end
  -- Choose highlight based on modified status
  local highlight_group = vim.bo.modified and 'StatusLineFNameModified' or 'StatusLineFName'

  -- Format with highlight
  return hi_pattern:format(highlight_group, filepath)
end

-- Function to show the filename with modified status
function cmp.filename_inactive()
  local filepath = vim.fn.expand('%:p') -- Get the full path of the current file
  local home = os.getenv('HOME')
  if filepath:sub(1, #home) == home then
    filepath = '~' .. filepath:sub(#home + 1)
  end

  -- Format with highlight
  return hi_pattern:format('StatusLineInactive', filepath)
end

function cmp.progress()
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local total_lines = vim.fn.line('$')
  local percent = math.floor((line / total_lines) * 100)

  local current_mode = vim.api.nvim_get_mode().mode
  local mode_info = mode_map[current_mode] or { name = current_mode, hl = 'Normal' }

  return string.format('%%#%s# %2d:%-1d %1d%%%% [%d]', mode_info.hl, line, col, percent, total_lines)
end

-- Function to show trailing whitespace
function cmp.trailing()
  local result = ''

  if vim.api.nvim_get_mode().mode == 'n' then
    local space = vim.fn.search([[\s\+$]], 'nwc')
    result = space ~= 0 and string.format(' ☲ trailing [%s] ', space) or ''
  end

  return hi_pattern:format('StatusLineTrailing', result)
end

-- Build the statusline
local statusline_active = {
  '%{%v:lua._statusline_component("mode_status")%}',
  '%{%v:lua._statusline_component("filename_active")%}',
  '%r',
  '%=',
  '%{&filetype} ',
  '%{%v:lua._statusline_component("progress")%}',
  '%{%v:lua._statusline_component("trailing")%}',
}

local statusline_inactive = {
  '%{%v:lua._statusline_component("filename_inactive")%}',
}

-- Function to set the status line based on the active window
local function set_statusline()
  local current_win = vim.api.nvim_get_current_win()
  local windows = vim.api.nvim_list_wins() -- Get a list of all windows

  for _, win in ipairs(windows) do
    if win == current_win then
      -- Set status line for the active window
      vim.api.nvim_win_set_option(win, 'statusline', table.concat(statusline_active, ' '))
    else
      -- Set status line for inactive windows
      vim.api.nvim_win_set_option(win, 'statusline', table.concat(statusline_inactive, ' '))
    end
  end
end

-- Set initial status line
set_statusline()

-- Create autocommands to update the status line on window focus changes
vim.api.nvim_create_augroup("CustomStatusLine", { clear = true })

-- Define events for updating the status line
local events = { "WinEnter", "WinLeave", "BufWinEnter" }

-- Create the autocommands for each event
for _, event in ipairs(events) do
  vim.api.nvim_create_autocmd(event, {
    group = "CustomStatusLine",
    callback = set_statusline, -- Call set_statusline for each event
  })
end
