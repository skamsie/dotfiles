return   {
  'norcalli/nvim-colorizer.lua',
  enabled = true,
  config = function()
    require 'colorizer'.setup({
      'css';
      'lua';
    }, { mode = 'foreground' })
  end
}
