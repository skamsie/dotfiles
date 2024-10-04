-- Nvim dashboard

local items = {
  -- icon | key | title | command
  '   |   |                                       |',
  '   |   | Bookmarks                             |',
  '  | a | ~/.alacritty.toml                     | e ~/.alacritty.toml',
  '  | u | ~/.zshrc                              | e ~/.zshrc',
  '  | e | ~/.config/nvim/init.lua               | e ~/.config/nvim/init.lua',
  '  | p | ~/.config/nvim/lua/plugins            | e ~/.config/nvim/lua/plugins',
  '   |   |                                       |',
  '   |   | Actions                               |',
  '󰚰  | s | Sync plugins                          | Lazy sync',
  '  | f | Find File                             | FzfLua files',
  '󰋚  | h | History                               | FzfLua oldfiles',
  '󰋚  | c | Commands history                      | FzfLua command_history',
  '  | q | Quit                                  | q',
}

local ascii_art = {
  [[                                    /\                                ]],
  [[                               /\  //\\                               ]],
  [[                        /\    //\\///\\\        /\                    ]],
  [[                       //\\  ///\////\\\\  /\  //\\                   ]],
  [[          /\          /  ^ \/^ ^/^  ^  ^ \/^ \/  ^ \                  ]],
  [[         / ^\    /\  / ^   /  ^/ ^ ^ ^   ^\ ^/  ^^  \                 ]],
  [[        /^   \  / ^\/ ^ ^   ^ / ^  ^    ^  \/ ^   ^  \       ^        ]],
  [[       /  ^ ^ \/^  ^\ ^ ^ ^   ^  ^   ^   ____  ^   ^  \     /|\       ]],
  [[      / ^ ^  ^ \ ^  _\___________________|  |_____^ ^  \   /|||\      ]],
  [[     / ^^  ^ ^ ^\  /______________________________\ ^ ^ \ /|||||\     ]],
  [[    /  ^  ^^ ^ ^  /________________________________\  ^  /|||||||\    ]],
  [[   /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /|||||||||\   ]],
  [[  / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |       ]],
  [[ / ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||~~~~~~~~~~| |~~~~~~ ]],
  [[ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ]],
}

local winter_ascii_art = {
  [[                                    /\                                ]],
  [[                               /\  //\\                               ]],
  [[                        /\    //\\///\\\        /\                    ]],
  [[                       //\\  ///\////\\\\  /\  //\\                   ]],
  [[          /\          /  ^ \/^ ^/^  ^  ^ \/^ \/  ^ \                  ]],
  [[         / ^\    /\  / ^   /  ^/ ^ ^ ^   ^\ ^/  ^^  \                 ]],
  [[        /^   \  / ^\/ ^ ^   ^ / ^  ^    ^  \/ ^   ^  \       󰓎        ]],
  [[       /  ^ ^ \/^  ^\ ^ ^ ^  ^   ^    ^  ____  ^   ^  \     /|\       ]],
  [[      / ^ ^  ^ \ ^  _\___________________|  |_____^ ^  \   /||o\      ]],
  [[     / ^^  ^ ^ ^\  /______________________________\ ^ ^ \ /|o|||\     ]],
  [[    /  ^  ^^ ^ ^  /________________________________\  ^  /|||||o|\    ]],
  [[   /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /||o||||||\   ]],
  [[  / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |       ]],
  [[ / ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||oooooooooo| |oooooo ]],
  [[ oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo ]],
}

-- switch to winter_ascii in December :)
if os.date('%m')  == '12' then ascii_art = winter_ascii_art end

-- right | left
local align_shortcut = 'left'

-- this is only used to determine if we should also change
-- the working directory before the command. It should match the items from
-- the items table for it to work
local dir_icon = ' '

-- set colors
local hl_selection = 'AlphaHeaderLabel'
local hl_header = 'AlphaHeader'
local hl_normal = 'LineNr'

-- add a function len() to retrieve the number of items
-- used for centering content vertically
setmetatable(items, {
  __index = {
    len = function(len)
      local incr = 0
      for _ in pairs(len) do incr = incr + 1 end
      return incr
    end
  }
})

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end
local function get_item(str, n)
  local parts = {}
  for part in string.gmatch(str, "([^|]+)") do
    table.insert(parts, trim(part))
  end

  return parts[n] or ''
end

-- get length of longest item in the list
-- use to set width (automatically centered)
local function longest_item_text_len(items)
  local text_len = 1
  local padding = align_shortcut == 'left' and 4 or 6 

  for _,v in pairs(items) do
    local v_len = #(get_item(v, 1)) + #(get_item(v, 2)) + #(get_item(v, 3))
    if v_len > text_len then
      text_len = v_len
    end
  end

  -- some threshold to accomodate for whitespaces and shortcut brackets
  return text_len + padding
end

return {
  'goolord/alpha-nvim',
  config = function()
    local plugins_count = require('lazy').stats().count
    local alpha = require('alpha')
    local datetime = os.date(' %d-%m-%Y')
    local home = os.getenv('HOME')
    local pwd = vim.loop.cwd():gsub(home, '~')
    local width = longest_item_text_len(items)
    local cursor_position = align_shortcut == 'left' and 1 or width - 2

    if pwd == '~' then pwd = ' ' .. home end

    -- Change the highlight of the current line
    -- To disable, simply comment until 'Implementation END'
    -- Create an autocommand group for handling the dynamic line color changes
    local group = vim.api.nvim_create_augroup('CursorLineColorChange', { clear = true })

    -- Create a dedicated namespace for our highlights
    local highlight_ns = vim.api.nvim_create_namespace('CursorLineHighlight')

    local function highlight_line(line_number, hl_group)
      -- Adjust the line number to 0-based for highlighting
      vim.api.nvim_buf_add_highlight(0, highlight_ns, 'CursorLineTemp', line_number - 1, 0, -1)
      vim.cmd(string.format('highlight link CursorLineTemp %s', hl_group))
    end
    -- Hook into alpha.move_cursor and add line highlighting
    local alpha_move_cursor_original = alpha.move_cursor
    function alpha.move_cursor(window)
      -- Get the current line before moving the cursor
      local current_line = vim.api.nvim_win_get_cursor(window)[1]
      -- Call the original alpha move cursor function
      alpha_move_cursor_original(window)
      -- After alpha moves the cursor, get the new line number
      local new_line = vim.api.nvim_win_get_cursor(window)[1]
      -- Clear previous highlights from the highlight namespace
      vim.api.nvim_buf_clear_namespace(0, highlight_ns, 0, -1)
      -- Highlight the new current line
      highlight_line(new_line, hl_selection)
    end
    -- Implementation END

    local function generate_empty_lines(size)
      local fill = {}
      for _ = 1, size do
        table.insert(fill, "")
      end
      return fill
    end

    -- center ascii_art vertically by adding empty lines
    local function center_ascii_art(ascii_art, adjust)
      local size = math.floor(vim.o.lines / 2) - math.ceil(#ascii_art / 2) - (adjust - 2)
      local fill = generate_empty_lines(size)
      return vim.list_extend(fill, ascii_art)
    end

    local ascii_art = center_ascii_art(ascii_art, items:len())

    local function content()
      local body = {}
      for _,v in pairs(items) do
        local icon = get_item(v, 1)
        local shortcut = get_item(v, 2)
        local title = get_item(v, 3)
        local action = function()
          if icon == trim(dir_icon) then
            vim.cmd(get_item(v, 4) .. ' | cd %:p:h')
          else
            vim.cmd(get_item(v, 4))
          end
        end 

        if shortcut == nil or shortcut == '' then
          if title then
            table.insert(body, {
              type = 'text',
              -- align a bit to the left to be same with the other items
              val = title .. string.rep(' ', width - title:len() - 1),
              opts = { position = 'center', hl = hl_header }
            })
          end
          -- insert padding for empty row
          table.insert(body, { type = 'padding', val = 1 })
        else
          table.insert(body, {
            type = 'button',
            val = string.format(' %s  %s', get_item(v, 1), title),
            on_press = action,
            opts = {
              keymap = { 'n', shortcut, action },
              shortcut = '[' .. shortcut .. ']',
              align_shortcut = align_shortcut,
              position = 'center',
              hl = hl_normal,
              hl_shortcut = {{hl_selection, 1, 2}},
              cursor = cursor_position,
              width = width,
              shrink_margin = true
            }
          })
        end
      end

      return body
    end

    require("alpha").setup {
      opts = { noautocmd = true },
      layout = {
        -- ascii art
        { type = 'text', val = ascii_art, opts = { position = 'center', hl = hl_normal } },
        { type = 'padding', val = 1 },
        -- first header line
        { type = 'text', val = pwd, opts = { position = 'center', hl = hl_header } },
        -- second header line
        {
          type = 'text',
          val = datetime .. ' | ' .. plugins_count .. ' plugins loaded',
          opts = { position = 'center', hl = hl_header }
        },
        -- body
        { type = 'group', val = content(), spacing = 1 },
        { type = 'padding', val = 2 },
      }
    }
  end
}
