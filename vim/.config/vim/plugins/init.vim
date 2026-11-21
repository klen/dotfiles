" Native packages
" Packages live outside the repo in ~/.vim/pack/plugins/start.

let g:plugins = [
    \ ['lsp', 'https://github.com/yegappan/lsp'],
    \ ['vim-fugitive', 'https://github.com/tpope/vim-fugitive'],
    \ ['vim-surround', 'https://github.com/tpope/vim-surround'],
    \ ['vim-repeat', 'https://github.com/tpope/vim-repeat'],
    \ ['fern.vim', 'https://github.com/lambdalisue/fern.vim'],
    \ ['fzf', 'https://github.com/junegunn/fzf'],
    \ ['fzf.vim', 'https://github.com/junegunn/fzf.vim'],
    \ ['vim-test', 'https://github.com/vim-test/vim-test'],
    \ ['copilot.vim', 'https://github.com/github/copilot.vim']
    \ ]

let g:copilot_no_tab_map = v:true

let s:here = expand('<sfile>:p:h')
let s:packdir = expand('~/.vim/pack/plugins/start')

function! s:plugin_dir(name) abort
    return s:packdir . '/' . a:name
endfunction

function! s:install(...) abort
    call mkdir(s:packdir, 'p')
    let installed = 0

    for [name, repo] in g:plugins
        let dir = s:plugin_dir(name)
        if isdirectory(dir)
            continue
        endif
        echomsg 'Installing ' . name . '...'
        call system('git clone --depth=1 ' . shellescape(repo) . ' ' . shellescape(dir))
        if v:shell_error
            echohl ErrorMsg
            echomsg 'Failed to install ' . name
            echohl None
        else
            let installed = 1
        endif
    endfor

    if installed
        silent! helptags ALL
    endif

    if a:0 && installed
        packloadall
        source $MYVIMRC
    endif
endfunction

function! s:update() abort
    for [name, repo] in g:plugins
        let dir = s:plugin_dir(name)
        if !isdirectory(dir)
            continue
        endif
        echomsg 'Updating ' . name . '...'
        call system('git -C ' . shellescape(dir) . ' pull --ff-only')
        if v:shell_error
            echohl ErrorMsg
            echomsg 'Failed to update ' . name
            echohl None
        endif
    endfor
    silent! helptags ALL
    echomsg 'Done. Restart Vim to apply updates.'
endfunction

function! s:status() abort
    for [name, repo] in g:plugins
        echomsg (isdirectory(s:plugin_dir(name)) ? '[x] ' : '[ ] ') . name
    endfor
endfunction

command! -bar PackInstall call s:install(1)
command! -bar PackUpdate call s:update()
command! -bar PackStatus call s:status()

" Plugin list: <CR> config, u update, d delete, r re-check upstream, q close
let s:init_file = expand('<sfile>:p')
let s:list_buf = -1
let s:rows = {} " line number -> plugin name

function! s:new_commits(dir) abort
    if !isdirectory(a:dir . '/.git')
        return 0
    endif
    let out = system('git -C ' . shellescape(a:dir) . ' rev-list --count HEAD..origin/HEAD 2>/dev/null')
    return v:shell_error ? 0 : str2nr(out)
endfunction

let s:jobs = []

function! s:row_of(name) abort
    for [lnum, name] in items(s:rows)
        if name ==# a:name
            return str2nr(lnum)
        endif
    endfor
    return 0
endfunction

function! s:mark(name, behind) abort
    let lnum = s:row_of(a:name)
    if lnum < 1 || !bufloaded(s:list_buf) || bufwinnr(s:list_buf) < 0
        return
    endif
    let text = a:name . (a:behind > 0 ? '  ↑' . a:behind : '')
    call setbufvar(s:list_buf, '&modifiable', 1)
    call setbufline(s:list_buf, lnum, text)
    call setbufvar(s:list_buf, '&modifiable', 0)
endfunction

function! s:after_fetch(name, dir) abort
    call s:mark(a:name, s:new_commits(a:dir))
endfunction

" Fetch in the background: "r" must not block on the network.
function! s:fetch(name, dir) abort
    if !isdirectory(a:dir . '/.git')
        return
    endif
    let l:name = a:name
    let l:dir = a:dir
    call add(s:jobs, job_start(['git', '-C', a:dir, 'fetch', '--quiet'], {
                \ 'exit_cb': {_job, _status -> timer_start(0, {-> s:after_fetch(l:name, l:dir)})},
                \ }))
endfunction

function! s:render_list(...) abort
    let fetch = a:0 ? a:1 : 0
    let lines = []
    let s:rows = {}

    for [title, installed] in [['Installed', 1], ['Not installed', 0]]
        let names = []
        for [name, repo] in g:plugins
            if isdirectory(s:plugin_dir(name)) == installed
                call add(names, name)
            endif
        endfor
        if empty(names)
            continue
        endif
        call sort(names)
        if !empty(lines)
            call add(lines, '')
        endif
        call add(lines, title)
        for name in names
            let dir = s:plugin_dir(name)
            if fetch
                call s:fetch(name, dir)
            endif
            let behind = installed ? s:new_commits(dir) : 0
            call add(lines, name . (behind > 0 ? '  ↑' . behind : ''))
            let s:rows[len(lines)] = name
        endfor
    endfor

    setlocal modifiable
    silent %delete _
    call setline(1, lines)
    setlocal nomodifiable nomodified

    if exists('w:pack_header')
        silent! call matchdelete(w:pack_header)
    endif
    let w:pack_header = matchadd('Title', '^\(Installed\|Not installed\)$')
endfunction

function! s:current_plugin() abort
    return get(s:rows, line('.'), '')
endfunction

function! s:update_current() abort
    let name = s:current_plugin()
    let dir = s:plugin_dir(name)
    if empty(name) || !isdirectory(dir)
        return
    endif
    echomsg 'Updating ' . name . '...'
    call system('git -C ' . shellescape(dir) . ' pull --ff-only 2>&1')
    if v:shell_error
        echohl ErrorMsg | echomsg 'Failed to update ' . name | echohl None
    else
        echomsg 'Updated ' . name
    endif
    call s:render_list()
endfunction

function! s:delete_current() abort
    let name = s:current_plugin()
    if empty(name)
        return
    endif
    if confirm('Delete ' . name . '?', "&Yes\n&No", 2) != 1
        return
    endif
    call delete(s:plugin_dir(name), 'rf')
    call s:render_list()
endfunction

" Convention: plugins are configured in plugins/init.vim, config.vim or servers.vim
function! s:goto_config() abort
    let name = s:current_plugin()
    if empty(name)
        return
    endif
    for file in [s:init_file,
                \ expand('<sfile>:p:h') . '/config.vim',
                \ expand('<sfile>:p:h') . '/servers.vim']
        if !filereadable(file)
            continue
        endif
        let lnum = match(readfile(file), '\V' . escape(name, '\') . '\m')
        if lnum >= 0
            execute 'edit' fnameescape(file)
            call cursor(lnum + 1, 1)
            normal! ^
            return
        endif
    endfor
    echomsg 'No config found for ' . name
endfunction

function! s:open_list() abort
    if s:list_buf > 0 && bufexists(s:list_buf) && bufwinnr(s:list_buf) > 0
        execute bufwinnr(s:list_buf) . 'wincmd w'
        return
    endif
    if s:list_buf < 0 || !bufexists(s:list_buf)
        let s:list_buf = bufadd('Packages')
        call bufload(s:list_buf)
        call setbufvar(s:list_buf, '&buflisted', 0)
        call setbufvar(s:list_buf, '&buftype', 'nofile')
        call setbufvar(s:list_buf, '&swapfile', 0)
        call setbufvar(s:list_buf, '&bufhidden', 'hide')
    endif
    execute 'vsplit'
    execute 'buffer' s:list_buf
    call s:render_list()
    nnoremap <buffer> <silent> <CR> :call <SID>goto_config()<CR>
    nnoremap <buffer> <silent> u :call <SID>update_current()<CR>
    nnoremap <buffer> <silent> d :call <SID>delete_current()<CR>
    nnoremap <buffer> <silent> r :call <SID>render_list(1)<CR>
    nnoremap <buffer> <silent> q :close<CR>
    setlocal statusline=\ <CR>:config\ \ u:update\ \ d:delete\ \ r:recheck\ \ q:close
endfunction

command! -bar PackList call s:open_list()

nnoremap <silent> <leader>pl :PackList<CR>
nnoremap <silent> <leader>pu :PackUpdate<CR>
nnoremap <silent> <leader>pi :PackInstall<CR>
nnoremap <silent> <leader>pc :PackStatus<CR>

" The lsp plugin reads g:lsp_servers on load (:h g:lsp_servers), so the specs
" are sourced before packloadall.
execute 'source' fnameescape(s:here . '/../lsp/servers.vim')

call s:install()
packloadall

" Per-plugin config, one file per plugin.
" lsp/ pulls in lsp/init.vim (options, keymaps, autocommands).
for s:plugin in ['lsp', 'fzf', 'vim-fugitive', 'vim-test', 'fern']
    execute 'source' fnameescape(s:here . '/' . s:plugin . '.vim')
endfor
