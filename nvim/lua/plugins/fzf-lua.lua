-- Improved fzf.vim written in lua
return {
  "ibhagwan/fzf-lua",
  config = function()
    local function set_fzf_keymap(key, func)
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
          width = 0.9,
          height = 0.75,
          border = 'single',
          prompt = 'B',
          backdrop = 100,
          preview = {
             border         = 'border',        -- border|noborder, applies only to
             wrap           = 'nowrap',        -- wrap|nowrap
             hidden         = 'nohidden',      -- hidden|nohidden
             layout         = 'flex',          -- horizontal|vertical|flex
          },
        },
        fzf_opts = {
          ['--layout'] = 'default',
          ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-history'
        },
        fzf_colors = {
          ['fg']          = { 'fg', 'CursorLine' },
          ['bg']          = { 'bg', 'Normal' },
          ['hl']          = { 'fg', 'Directory' },
          ['fg+']         = { 'fg', 'Normal' },
          ['bg+']         = { 'bg', 'CursorLine' },
          ['hl+']         = { 'fg', 'Boolean' },
          ['info']        = { 'fg', 'PreProc' },
          ['prompt']      = { 'fg', 'Conditional' },
          ['pointer']     = { 'fg', 'Exception' },
          ['marker']      = { 'fg', 'Keyword' },
          ['spinner']     = { 'fg', 'Label' },
          ['header']      = { 'fg', 'Comment' },
          ['gutter']      = '-1',
        },
        defaults = {
          winopts = { treesitter = false },
          file_icons = false,
          --formatter = 'path.dirname_first',
          hls = {
            dir_part = 'Normal',
            file_part = 'Normal',
            path_linenr = 'Normal',
            cursorlinenr = 'Normal'
          }
        },
        files = {
          winopts = { preview = { delay = 10 } }
        },
        oldfiles = {
          winopts = { preview = { delay = 10 } }
        },
        grep = {
          actions = {
            ['ctrl-g'] = actions.toggle_ignore,
            ['ctrl-q'] = actions.send_to_qf
          }
        }
      }
    )
  end
}
