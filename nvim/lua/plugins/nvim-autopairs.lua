return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = true,
  init = function()
    local npairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')

    npairs.setup({})

    -- Add rule to automatically pair `|` in Ruby files with smart movement
    npairs.add_rules({
      Rule('|', '|', 'ruby'):with_move(function(opts)
        return opts.char == '|'
      end)
    })
  end
}
