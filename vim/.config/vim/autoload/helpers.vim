" Shared helpers

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Statusline
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#statusline() abort
    let mode = mode()
    let mode = mode ==# 'n' ? 'N'
                \ : mode ==# 'i' ? 'I'
                \ : mode ==# 'R' ? 'R'
                \ : mode ==# 'c' ? 'C'
                \ : mode ==# 't' ? 'T'
                \ : index(['v', 'V', "\<C-v>"], mode) >= 0 ? 'V'
                \ : 'N'

    let branch = get(b:, 'gitbranch', '')

    let file = expand('%:.')
    if empty(file)
        let file = '[No Name]'
    endif

    return ' ' . mode
                \ . ' | ' . (empty(branch) ? '' : branch . ' | ')
                \ . file . (&modified ? ' +' : '')
                \ . ' | ' . &filetype
                \ . ' | ' . line('.') . ':' . col('.')
                \ . ' | ' . line('$') . ' lines'
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Save / copy
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#save() abort
    if &buftype !=# ''
        execute "normal! \<CR>"
        return
    endif
    write
endfunction

function! helpers#fast_save() abort
    if &modified
        silent noautocmd write
    endif
endfunction

function! helpers#copy_location() abort
    let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    let name = char =~# '\w' ? expand('<cword>') : ''
    let text = expand('%:.') . ':' . line('.') . (empty(name) ? '' : ' (' . name . ')')
    call setreg('+', text)
    echo 'Copied: ' . text
endfunction

function! helpers#copy_location_range() range abort
    let first = line("'<")
    let last = line("'>")
    if first > last
        let [first, last] = [last, first]
    endif
    let text = expand('%:.') . ':' . (first == last ? first : first . '-' . last)
    call setreg('+', text)
    echo 'Copied: ' . text
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Comment toggle (native replacement for vim-commentary)
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! s:toggle_comment(first, last) abort
    let commentstring = &commentstring
    if commentstring !~# '%s'
        return
    endif

    let prefix = matchstr(commentstring, '^[^%]*')
    let suffix = matchstr(commentstring, '%s\zs.*')
    let lines = getline(a:first, a:last)
    let nonblank = filter(copy(lines), 'v:val =~# "\\S"')
    if empty(nonblank)
        return
    endif

    let prefix_re = escape(prefix, '\.*$^~[]')
    let suffix_re = escape(suffix, '\.*$^~[]')
    let all_commented = 1
    for line in nonblank
        if line !~# '^\s*' . prefix_re
            let all_commented = 0
            break
        endif
    endfor

    for i in range(0, len(lines) - 1)
        if lines[i] =~# '^\s*$'
            continue
        endif
        if all_commented
            let text = substitute(lines[i], '^\(\s*\)' . prefix_re . '\s\?', '\1', '')
            if !empty(suffix)
                let text = substitute(text, '\s*' . suffix_re . '$', '', '')
            endif
            call setline(a:first + i, text)
        else
            let space = prefix =~# '\s$' ? '' : ' '
            let text = substitute(lines[i], '^\(\s*\)', '\1' . prefix . space, '')
            call setline(a:first + i, empty(suffix) ? text : text . suffix)
        endif
    endfor
endfunction

" "gcc" and visual "gc"
function! helpers#toggle_comment() range abort
    call s:toggle_comment(a:firstline, a:lastline)
endfunction

" "gc{motion}" operator
function! helpers#comment_op(_type) abort
    call s:toggle_comment(line("'["), line("']"))
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Python breakpoint
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#toggle_breakpoint() abort
    let lnum = line('.')
    if getline(lnum) =~# '^\s*breakpoint()'
        execute 'normal! dd'
        return
    endif

    let indent = matchstr(getline(prevnonblank(lnum)), '^\s*')
    call append(lnum - 1, indent . 'breakpoint()')
    normal! k
    call helpers#fast_save()
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Quickfix from external command
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#qf_from_cmd(title, cmd, efm) abort
    let lines = systemlist(a:cmd . ' 2>&1')
    let code = v:shell_error

    if empty(lines) && code != 0
        echohl ErrorMsg
        echomsg printf('Error running command (%d): %s', code, a:cmd)
        echohl None
        return
    endif

    call setqflist([], ' ', {'title': a:title, 'lines': lines, 'efm': a:efm})
    if !empty(getqflist())
        copen
    else
        cclose
        echomsg a:title . ': no issues'
    endif
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Completion / Copilot
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#accept() abort
    if pumvisible()
        return "\<C-y>"
    endif
    if exists('g:loaded_copilot')
        return copilot#Accept("\<C-y>")
    endif
    return "\<C-y>"
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Windows / tmux
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

" Undo states menu
function! helpers#undo_menu() abort
    let entries = undotree().entries
    if len(entries) <= 1
        echomsg 'No undo history'
        return
    endif

    let labels = []
    for entry in reverse(copy(entries))
        call add(labels, (entry.curhead ? '* ' : '  ') . entry.seq . ': '
                     . strftime('%H:%M:%S', entry.time)
                     . (empty(entry.save) ? '' : ' (saved)'))
    endfor

    let choice = inputlist(['Undo states (newest first):']
                 + map(range(len(labels)), 'v:val + 1 . ") " . labels[v:val]'))
    if choice < 1 || choice > len(labels)
        return
    endif
    execute 'undo' entries[len(entries) - choice].seq
endfunction

function! helpers#move(direction) abort
    let dirs = {'h': 'L', 'j': 'D', 'k': 'U', 'l': 'R'}
    let current = winnr()
    execute 'wincmd ' . a:direction
    if winnr() == current && $TMUX !=# ''
        call system('tmux select-pane -' . dirs[a:direction])
    endif
endfunction

function! helpers#fern_open(reveal) abort
    let dir = a:reveal ? expand('%:p:h') : getcwd()
    if empty(dir) || !isdirectory(dir)
        let dir = getcwd()
    endif
    let args = ' ' . fnameescape(dir) . ' -drawer -toggle'
    if a:reveal && !empty(expand('%:t'))
        let args .= ' -reveal=%'
    endif
    execute 'Fern' . args
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Yank highlight
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#highlight_yank() abort
    let start = getpos("'[")
    let end = getpos("']")
    if start[1] == 0 || end[1] == 0
        return
    endif

    let positions = []
    for lnum in range(start[1], end[1])
        let scol = lnum == start[1] ? start[2] : 1
        let ecol = lnum == end[1] ? end[2] : max([1, strlen(getline(lnum))])
        if ecol >= scol
            call add(positions, [lnum, scol, ecol - scol + 1])
        endif
    endfor
    if empty(positions)
        return
    endif

    let id = matchaddpos('Visual', positions)
    call timer_start(150, {-> execute('silent! call matchdelete(' . id . ')')})
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" netrw keys
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function! helpers#netrw_open() abort
    if getline('.') =~# '/\s*$'
        call feedkeys("\<Plug>NetrwLocalBrowseCheck", 'x')
        return
    endif

    let winid = win_getid()
    call feedkeys("\<Plug>NetrwLocalBrowseCheck", 'x')
    if win_id2win(winid) > 0 && getbufvar(winbufnr(winid), '&filetype') ==# 'netrw'
        call win_gotoid(winid)
        close
    endif
endfunction

function! helpers#netrw_up() abort
    execute 'Explore ' . fnameescape(fnamemodify(b:netrw_curdir, ':h'))
endfunction

function! helpers#netrw_close() abort
    if winnr('$') > 1
        close
    else
        bdelete
    endif
endfunction
