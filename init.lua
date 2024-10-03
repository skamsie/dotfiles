-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.fn.setenv('TERM', 'xterm-256color')

-- NVIM SETTINGS
vim.g.mapleader = " "
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.opt.matchpairs:append("<:>")
vim.opt.swapfile = false
vim.opt.updatetime = 500
vim.opt.colorcolumn = "80"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamed"

-- NETRW settings
vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 33
vim.g.netrw_localrmdir = 'rm -rf'

-- Resize vertical split
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w><', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>>', { noremap = true })

vim.cmd [[
  autocmd User AlphaReady set laststatus=0 | autocmd BufUnload <buffer> set laststatus=2

  " scroll by 10 percent
  function s:scroll(direction)
    let l:h = float2nr(0.1 * winheight('%'))

    execute "normal! " . l:h . (a:direction == 'down' ? "\<C-E>" : "\<C-Y>")
  endfunction

  " Custom scroll
  noremap <silent><c-u> :call <SID>scroll('up')<cr>
  noremap <silent><c-d> :call <SID>scroll('down')<cr>
]]

require("lazy").setup({
  spec = {
    -- Solarized colors
    {
      'maxmx03/solarized.nvim',
      lazy = false,
      priority = 1000,
      opts = {
        transparent = { enabled = true },
        on_colors = function()
          return {
            -- match .alacrittty.toml
            green  = '#9fb927',
            blue   = '#4b9ffc',
            cyan   = '#49b6a9',
            orange = '#e86c48',
            yellow = '#d09a27',
            violet = '#837CE4',
            base0 = '#a6b0b0',
            base01 = '#6b8287',
            magenta = '#cf598e'
          }
        end,
        on_highlights = function(colors, color)
          local lighten = color.lighten

          return {
            -- EndOfBuffer = { fg = colors.magenta },
            Boolean = { fg = colors.magenta },
            Changed = { fg = colors.yellow },
            Comment = { italic = true },
            Define = { fg = colors.green, bold = false },
            Identifier = { fg = colors.base0 },
            IncSearch = { bg = colors.red, fg = '#073642', bold = false },
            Normal = { fg = colors.base0 },
            Number = { fg = colors.magenta },
            Property = { fg = colors.base0 },
            Search = { bg = colors.yellow, fg = '#073642', bold = false },
            Type = { fg = colors.yellow },
            rubyFloat = { link = Number },
            rubyInteger = { link = Number },
            rubyMacro = { fg = colors.orange },
            rubyMagicComment = { fg = colors.orange },
            rubyPercentStringDelimiter = { fg = colors.violet },
            rubyString = { fg = colors.green },
            rubyStringDelimiter = { fg = colors.green },
            rubySymbol = { fg = colors.cyan },
          }
        end
      },
      config = function(_, opts)
        vim.o.termguicolors = true
        vim.o.background = 'dark'
        require('solarized').setup(opts)
        vim.cmd.colorscheme 'solarized'
      end,
    },

    -- Because letters are much easier to touch type than numbers
    {
      'skamsie/vim-lineletters',
      init = function()
        vim.g.lineletters_settings = { prefix_chars = { ',', ';', 'j' } }
        vim.api.nvim_set_keymap('', ',', '<Plug>LineLetters', { silent = true })
      end
    },

    -- Highlight the current search result in a different style than the other search results.
    {
      'qxxxb/vim-searchhi',
      config = function()
        vim.g.searchhi_clear_all_autocmds = 'InsertEnter'
        vim.g.searchhi_update_all_autocmds = 'InsertLeave'
        vim.keymap.set('n', '<C-C>', '<Plug>(searchhi-clear-all)', { silent = true })
      end
    },
    {
      'goolord/alpha-nvim',
      config = function()
        local lazy = require("lazy")
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        local open_oldfiles = function() vim.cmd([[FzfLua oldfiles]]) end
        local datetime = os.date " %d-%m-%Y"
        local body = {}
        local width = 36
        local dir_icon = ' '

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
          '   |   |                                    |',
          '   |   | Bookmarks                          |',
          '  | e | ~/.config/nvim/init.lua            | e ~/.config/nvim/init.lua',
          '  | a | ~/.alacritty.toml                  | e ~/.alacritty.toml',
          '  | u | ~/.zshrc                           | e ~/.zshrc',
          '  | c | ~/github/skamsie/casetofoane       | e ~/github/skamsie/casetofoane',
          '   |   |                                    |',
          '   |   | Actions                            |',
          '󰚰  | s | Sync plugins                       | Lazy sync',
          '󰋚  | o | Recent Files                       | FzfLua oldfiles',
          '󰋚  | i | Recent Commands                    | FzfLua command_history',
          '  | q | Quit                               | q',
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
                hl_shortcut = 'Number',
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
            { type = 'text', val = header, opts = { position = 'center', hl = 'LineNr' } },
            { type = 'padding', val = 1 },
            { type = 'text', val = datetime, opts = { position = 'center', hl = 'LineNr' } },
            { type = 'group', val = body, spacing = 1 },
            { type = 'padding', val = 2 },
            { type = 'text', val = ' ' .. vim.loop.cwd(), opts = { position = 'center', hl = 'LineNr' } },
            { type = 'text', val = lazy.stats().count .. ' plugins loaded', opts = { position = 'center', hl = 'LineNr' } },
          }
        }
      end
    },

    -- Improved fzf.vim written in lua
    {
      "ibhagwan/fzf-lua",
      config = function()
        function set_fzf_keymap(key, func)
          vim.keymap.set(
          'n', '<leader>' .. key,
          function()
            require('fzf-lua')[func]()
          end,
          { noremap = true, silent = true }
          )
        end

        set_fzf_keymap('f', 'files')
        set_fzf_keymap('a', 'grep_project')

        -- calling `setup` is optional for customization
        local actions = require 'fzf-lua.actions'
        require("fzf-lua").setup(
        {
          winopts = {
            row = 0.5,
            col = 0.5,
            width = 0.8,
            height = 0.8,
            border = 'single',
            prompt = 'B'
          },
          fzf_opts = { ['--layout'] = 'default' },
          defaults = { file_icons = false },
          files = {
            winopts = { preview = { delay = 10 } }
          },
          oldfiles = {
            winopts = { preview = { delay = 10 } }
          },
          grep = {
            actions = {
              ["ctrl-g"] =  actions.toggle_ignore,
            }
          }
        }
        )
      end
    },
  },
  install = { colorscheme = { 'solarized' } },
  checker = { enabled = true },
  ui = {
    border = 'single',
    icons = {
      list = {
        "●",
        "▸",
        "■",
        "*",
      },
    },
  }
})
