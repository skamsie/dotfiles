-- in case of error
-- :call coc#util#install()
return {
  'neoclide/coc.nvim',
  enabled = true,
  config = function()
    vim.g.coc_global_extensions = {
      'coc-clangd',
      'coc-css',
      'coc-html',
      'coc-lua',
      'coc-solargraph',
      'coc-go',
      'coc-vimlsp',
    }

    vim.cmd[[
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
      nmap <silent> gF <Plug>(coc-fix-current)
    ]]
  end
}
