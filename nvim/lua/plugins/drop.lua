local enabled = true
local start_after = 20000 -- 20 seconds

function set_only_for_alpha()
  if not enabled then return end

  local screensaver_timer = 0
  local function stop_screensaver(restart_timer)
    require('drop.init').hide()
    vim.fn.timer_stop(screensaver_timer)

    if restart_timer then
      screensaver_timer = vim.fn.timer_start(start_after, function()
        require('drop.init').show()
      end)
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'alpha',
    callback = function()
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufEnter', 'ModeChanged' }, {
        buffer = 0,
        callback = function()
          stop_screensaver(true)
        end,
      })

      screensaver_timer = vim.fn.timer_start(start_after, function()
        require('drop.init').show()
      end)
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufNew' }, {
    callback = function()
      stop_screensaver(false)
    end
  })
end

set_only_for_alpha()

return {
  {
    'folke/drop.nvim',
    enabled = enabled,
    opts = {
      screensaver = false,
      max = 40,
      interval = 200,
      winblend = 100,
      theme = {
        symbols = { '󰌪', '' }, colors = { '#6b8287' },
      },
      filetypes = {}
    },
  }
}
