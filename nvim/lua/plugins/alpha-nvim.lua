-- Nvim dashboard / greeter
return {
  'goolord/alpha-nvim',
  config = function()
    local lazy = require("lazy")
    local alpha = require 'alpha'
    local datetime = os.date " %d-%m-%Y"
    local body = {}
    local width = 36
    local dir_icon = ' '
    local hl_selection = '@markup'
    local home = os.getenv('HOME')
    local pwd = vim.loop.cwd():gsub(home, '~')

    if pwd == '~' then pwd = ' ' .. home end

    -- Change the highlight of the current line (Generated with ChatGPRHT)
    -- To disable, simply comment until 'Implementation END'
    -- Create an autocommand group for handling the dynamic line color changes
    local group = vim.api.nvim_create_augroup('CursorLineColorChange', { clear = true })

    -- Create a dedicated namespace for our highlights
    local highlight_ns = vim.api.nvim_create_namespace("CursorLineHighlight")

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

    -- center header vertically by adding empty lines
    local function center_header(header, adjust)
      local size = math.floor(vim.o.lines / 2) - math.ceil(#header / 2) - (adjust - 2)
      local fill = generate_empty_lines(size)
      return vim.list_extend(fill, header)
    end

    local items = {
      '   |   |                                       |',
      '   |   | Bookmarks                             |',
      '  | a | ~/.alacritty.toml                     | e ~/.alacritty.toml',
      '  | u | ~/.zshrc                              | e ~/.zshrc',
      '  | e | ~/.config/nvim/init.lua               | e ~/.config/nvim/init.lua',
      '  | p | ~/.config/nvim/lua/plugins            | e ~/.config/nvim/lua/plugins',
      '  | c | ~/github/skamsie/casetofoane          | e ~/github/skamsie/casetofoane',
      '   |   |                                       |',
      '   |   | Actions                               |',
      '󰚰  | s | Sync plugins                          | Lazy sync',
      '  | f | Find File                             | FzfLua files',
      '󰋚  | o | Recent Files                          | FzfLua oldfiles',
      '󰋚  | i | Recent Commands                       | FzfLua command_history',
      '  | q | Quit                                  | q',
    }

    setmetatable(items, {
      __index = {
        len = function(len)
          local incr = 0
          for _ in pairs(len) do incr = incr + 1 end
          return incr
        end
      }
    })

    local header = center_header(
    {
      [[                                    /\                                 ]],
      [[                               /\  //\\                                ]],
      [[                        /\    //\\///\\\        /\                     ]],
      [[                       //\\  ///\////\\\\  /\  //\\                    ]],
      [[          /\          /  ^ \/^ ^/^  ^  ^ \/^ \/  ^ \                   ]],
      [[         / ^\    /\  / ^   /  ^/ ^ ^ ^   ^\ ^/  ^^  \                  ]],
      [[        /^   \  / ^\/ ^ ^   ^ / ^  ^    ^  \/ ^   ^  \       ^         ]],
      [[       /  ^ ^ \/^  ^\ ^ ^ ^   ^  ^   ^   ____  ^   ^  \     /|\        ]],
      [[      / ^ ^  ^ \ ^  _\___________________|  |_____^ ^  \   /|||\       ]],
      [[     / ^^  ^ ^ ^\  /______________________________\ ^ ^ \ /|||||\      ]],
      [[    /  ^  ^^ ^ ^  /________________________________\  ^  /|||||||\     ]],
      [[   /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /|||||||||\    ]],
      [[  / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |        ]],
      [[ / ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||~~~~~~~~~~| |~~~~~~~ ]],
      [[ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ]],
    }, items:len()
    )

    local function trim(s)
      return (s:gsub("^%s*(.-)%s*$", "%1"))
    end
    local function get_item(str, n)
      local parts = {}
      for part in string.gmatch(str, "([^|]+)") do
        table.insert(parts, trim(part))
      end

      return parts[n]
    end

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
            val = title .. string.rep(' ', width - title:len()),
            opts = { position = 'center', hl = 'IblIndent' }
          })
        end
        table.insert(body, { type = 'padding', val = 1 })
      else
        table.insert(body, {
          type = 'button',
          val = string.format(' %s  %s', get_item(v, 1), title),
          on_press = action,
          opts = {
            keymap = { 'n', shortcut, action },
            shortcut = '[' .. shortcut .. ']',
            align_shortcut = 'left',
            position = 'center',
            hl = 'LineNr',
            hl_shortcut = {{hl_selection, 1, 2}},
            cursor = 1,
            width = width,
            shrink_margin = true
          }
        })
      end
    end

    require("alpha").setup {
      opts = { noautocmd = true },
      layout = {
        { type = 'text', val = header, opts = { position = 'center', hl = 'LineNr', cursor = 1 } },
        { type = 'padding', val = 1 },
        { type = 'text', val = pwd, opts = { position = 'center', hl = 'IblIndent' } },
        { type = 'text', val = lazy.stats().count .. ' plugins loaded', opts = { position = 'center', hl = 'IblIndent' } },
        { type = 'group', val = body, spacing = 1 },
        { type = 'padding', val = 2 },
        { type = 'text', val = datetime, opts = { position = 'center', hl = 'IblIndent' } },
      }
    }
  end
}
