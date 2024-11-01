-- in case of error
-- :call coc#util#install()
return {
  'neoclide/coc.nvim',
  config = function()
    vim.g.coc_global_extensions = {
      'coc-clangd',
      'coc-css',
      'coc-html',
      'coc-lua',
      'coc-solargraph',
      'coc-vimlsp',
    }

    vim.cmd[[
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)
    ]]
  end
}
