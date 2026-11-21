" Editor setup

scriptencoding utf-8

let s:here = expand('<sfile>:p:h')

execute 'source' fnameescape(s:here . '/opts.vim')
execute 'source' fnameescape(s:here . '/keymaps.vim')
execute 'source' fnameescape(s:here . '/auto.vim')
execute 'source' fnameescape(s:here . '/filetypes.vim')
