" LSP setup
"
" Note: the server list itself is sourced by plugins/init.vim *before* the lsp
" plugin is loaded — the plugin reads g:lsp_servers on load (:h g:lsp_servers).

scriptencoding utf-8

let s:here = expand('<sfile>:p:h')

execute 'source' fnameescape(s:here . '/config.vim')
execute 'source' fnameescape(s:here . '/auto.vim')
