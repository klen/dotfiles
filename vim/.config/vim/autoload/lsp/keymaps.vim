" LSP buffer-local keymaps
"
" Called from lsp/auto.vim on User LspAttached / LspDetached.
" gr* for the action group, <leader>l* for client control.

scriptencoding utf-8

function! lsp#keymaps#attach() abort
    nnoremap <buffer> <silent> grd <Cmd>LspGotoDefinition<CR>
    nnoremap <buffer> <silent> grs <Cmd>LspShowSignature<CR>
    nnoremap <buffer> <silent> grn <Cmd>LspRename<CR>
    nnoremap <buffer> <silent> gra <Cmd>LspCodeAction<CR>
    xnoremap <buffer> <silent> gra <Cmd>LspCodeAction<CR>
    nnoremap <buffer> <silent> grf <Cmd>LspFormat<CR>
    nnoremap <buffer> <silent> grl <Cmd>LspFixAll<CR>
    nnoremap <buffer> <silent> grr <Cmd>LspShowReferences<CR>
    nnoremap <buffer> <silent> gri <Cmd>LspGotoImpl<CR>
    nnoremap <buffer> <silent> grt <Cmd>LspGotoTypeDef<CR>
    nnoremap <buffer> <silent> grx <Cmd>LspCodeLens<CR>
    nnoremap <buffer> <silent> K <Cmd>LspHover<CR>

    nnoremap <buffer> <silent> <leader>lh <Cmd>LspInlayHints toggle<CR>

    nnoremap <buffer> <silent> <leader>lwa :execute 'LspWorkspaceAddFolder ' . fnameescape(expand('%:p:h'))<CR>
    nnoremap <buffer> <silent> <leader>lwr :execute 'LspWorkspaceRemoveFolder ' . fnameescape(expand('%:p:h'))<CR>
    nnoremap <buffer> <silent> <leader>lwl <Cmd>LspWorkspaceListFolders<CR>

    nnoremap <buffer> <silent> <leader>cd <Cmd>LspDiag current<CR>
    nnoremap <buffer> <silent> <leader>cq <Cmd>LspDiag show<CR>
    nnoremap <buffer> <silent> <C-n> <Cmd>LspDiag nextWrap<CR>
    nnoremap <buffer> <silent> <C-p> <Cmd>LspDiag prevWrap<CR>

    nnoremap <buffer> <silent> <leader>li <Cmd>LspShowAllServers<CR>
    nnoremap <buffer> <silent> <leader>lr <Cmd>LspServer restart<CR>
    nnoremap <buffer> <silent> <leader>ls <Cmd>LspServer stop<CR>
endfunction

function! lsp#keymaps#detach() abort
    let keys = ['grd', 'grs', 'grn', 'gra', 'grf', 'grl', 'grr', 'gri', 'grt', 'grx',
                \ 'K', '<C-n>', '<C-p>', '<leader>lh',
                \ '<leader>lwa', '<leader>lwr', '<leader>lwl',
                \ '<leader>cd', '<leader>cq', '<leader>li', '<leader>lr', '<leader>ls']
    for key in keys
        execute 'silent! nunmap <buffer> ' . key
        execute 'silent! xunmap <buffer> ' . key
    endfor
endfunction
