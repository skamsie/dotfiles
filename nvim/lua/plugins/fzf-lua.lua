-- Improved fzf.vim written in lua
return {
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
    set_fzf_keymap('h', 'oldfiles')
    set_fzf_keymap('b', 'buffers')

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
          prompt = 'B',
          backdrop = 100
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
}
