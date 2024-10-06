-- Nvim dashboard

-- we need this for the oldfiles command
vim.cmd("rshada")

-- e: empty line
-- t: title
-- o: oldfile with index idx
-- f: file (e: filename)
-- d: directory (chdir and e: dirname)
-- a: action (vim command)
local elements = {
  { type = 't', txt = 'Pinned' },
  { type = 'o', icon = '󰋚 ', key = 'l', idx = 1 },
  { type = 'f', icon = ' ', key = 'a', txt = '~/.alacritty.toml' },
  { type = 'f', icon = ' ', key = 'e', txt = '~/.config/nvim/init.lua' },
  { type = 'd', icon = ' ', key = 'p', txt = '~/.config/nvim/lua/plugins' },
  { type = 'e' },
  { type = 't', txt = 'Actions' },
  { type = 'a', icon = ' ', key = 'o', txt = 'Open current directory', cmd = "execute 'edit ' . getcwd()" },
  { type = 'a', icon = '󰚰 ', key = 's', txt = 'Sync plugins', cmd = 'Lazy sync' },
  { type = 'a', icon = ' ', key = 'f', txt = 'Find file', cmd = 'FzfLua files' },
  { type = 'a', icon = '󰋚 ', key = 'h', txt = 'History', cmd = 'FzfLua oldfiles' },
  { type = 'a', icon = '󰋚 ', key = 'c', txt = 'Commands history', cmd = 'FzfLua command_history' },
  { type = 'a', icon = ' ', key = 'q', txt = 'Quit', cmd = 'qa' },
}

local settings = {
  -- right | left
  align_shortcut = 'left',
  current_line_highlight = true,
  -- strip lenght of oldfiles to this max len
  oldfile_txt_max_len = 38,
  datetime = os.date(' %d-%m-%Y'),
  hl_selection = 'AlphaHeaderLabel',
  hl_header = 'AlphaHeader',
  hl_normal = 'SpecialKey'
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

local function get_oldfile(idx)
  local home = vim.fn.expand('$HOME')
  local oldfiles = vim.v.oldfiles
  local empty = { original = '', shortened = '' }
  if #oldfiles == 0 then return empty end

  -- Check if file exists and is a regular file
  local function file_exists(filepath)
    local stat = vim.loop.fs_stat(filepath)
    return stat and stat.type == 'file' -- Only return true for regular files
  end

  local last_file
  local current_idx = idx

  -- Loop to find the next existing file
  while current_idx <= #oldfiles do
    last_file = oldfiles[current_idx]
    
    if file_exists(last_file) then
      break -- Found a valid file, exit loop
    else
      current_idx = current_idx + 1 -- Check the next file
    end
  end

  -- If no valid file found, return empty
  if not last_file or not file_exists(last_file) then return empty end

  -- Replace the home directory with '~'
  if last_file:find(home, 1, true) then
    last_file = last_file:gsub(home, '~')
  end

  local original = last_file
  local max_len = settings.oldfile_txt_max_len
  local shortened = last_file

  if #last_file > max_len then
    -- Split the remaining space for prefix
    local prefix_len = math.floor((max_len - 3) / 2)
    local suffix_len = max_len - 3 - prefix_len
    local prefix = last_file:sub(1, prefix_len)
    local suffix = last_file:sub(-suffix_len)
    shortened = prefix .. '...' .. suffix
  end

  return { original = original, shortened = shortened }
end

-- Function to update elements of type 'o' with oldfile data
local function update_elements_with_oldfile(elements)
  for _, element in ipairs(elements) do
    if element.type == 'o' and element.idx then
      local oldfile = get_oldfile(element.idx)
      
      if oldfile then
        element.txt = oldfile.shortened
        element.cmd = 'e ' .. oldfile.original
      end
    end
  end
end

update_elements_with_oldfile(elements)

-- switch to winter_ascii in December :)
if os.date('%m')  == '12' then ascii_art = winter_ascii_art end

-- add a function len() to retrieve the number of items
-- used for centering content vertically
setmetatable(elements, {
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

-- get length of longest item in the list
-- use to set width (automatically centered)
local function longest_item_text_len(items)
  local text_len = 0
  local padding = settings.align_shortcut == 'left' and 4 or 6 

  for _,v in pairs(items) do
    local v_len = #(v.icon or '') + #(v.key or '') + #(v.txt or '')
    if v_len > text_len then
      text_len = v_len
    end
  end

  -- some threshold to accomodate for whitespaces and shortcut brackets
  return text_len + padding
end

local function highligh_current_line(alpha)
  if settings.current_line_highlight == false then return end

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
    highlight_line(new_line, settings.hl_selection)
  end
end

return {
  'goolord/alpha-nvim',
  keys = { { '<leader>s', ':Alpha<cr>', desc = 'Trigger dashboard' } },
  event = 'VimEnter',
  lazy = false,
  config = function()
    highligh_current_line(require('alpha'))

    local plugins_count = require('lazy').stats().count
    local home = os.getenv('HOME')
    local pwd = vim.loop.cwd():gsub(home, '~')
    local width = longest_item_text_len(elements)
    local cursor_position = settings.align_shortcut == 'left' and 1 or width - 2

    if pwd == '~' then pwd = ' ' .. home end

    local function generate_empty_lines(size)
      local fill = {}
      for _ = 1, size do
        table.insert(fill, '')
      end
      return fill
    end

    -- center ascii_art vertically by adding empty lines
    local function center_ascii_art(ascii_art, adjust)
      local size = math.floor(vim.o.lines / 2) - math.ceil(#ascii_art / 2) - (adjust - 2)
      local fill = generate_empty_lines(size)
      return vim.list_extend(fill, ascii_art)
    end

    local ascii_art = center_ascii_art(ascii_art, elements:len())

    local function content()
      local body = {}
      for _,v in pairs(elements) do
        local icon = trim(v.icon or '')
        local shortcut = v.key
        local title = v.txt
        local action = function()
          if v.type == 'd' then
            vim.cmd('e ' .. v.txt .. ' | cd %:p:h')
          elseif v.type == 'f' then
            vim.cmd('e ' .. v.txt)
          elseif v.type == 'a' or v.type == 'o' then
            vim.cmd(v.cmd)
          end
        end 

        local padding = settings.align_shortcut == 'right' and 2 or 0 

        if shortcut == nil or shortcut == '' then
          if title then
            table.insert(body, {
              type = 'text',
              -- align a bit to the left to be same with the other items
              val = title .. string.rep(' ', width - title:len() - padding),
              opts = { position = 'center', hl = settings.hl_header }
            })
          end
          -- insert padding for empty row
          table.insert(body, { type = 'padding', val = 1 })
        else
          table.insert(body, {
            type = 'button',
            val = string.format(' %s  %s', icon, title),
            on_press = action,
            opts = {
              keymap = { 'n', shortcut, action },
              shortcut = '[' .. shortcut .. ']',
              align_shortcut = settings.align_shortcut,
              position = 'center',
              hl = settings.hl_normal,
              hl_shortcut = { { settings.hl_selection, 1, 2 } },
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
      opts = { noautocmd = false },
      layout = {
        -- ascii art
        { type = 'text', val = ascii_art, opts = { position = 'center', hl = settings.hl_normal } },
        { type = 'padding', val = 1 },
        -- first header line
        { type = 'text', val = pwd, opts = { position = 'center', hl = settings.hl_header } },
        -- second header line
        {
          type = 'text',
          val = settings.datetime .. ' | ' .. plugins_count .. ' plugins loaded',
          opts = { position = 'center', hl = settings.hl_header }
        },
        { type = 'padding', val = 2 },
        -- body
        { type = 'group', val = content(), spacing = 1 },
      }
    }
  end
}
