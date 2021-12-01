" Recursive vimgrep
fun! helpers#vimgrep() "{{{ 
    let pattern = input("Search for pattern: ", expand("<cword>"))
    if pattern == ""
        return
    endif

    let cwd = getcwd()
    let startdir = input("Start searching from directory: ", cwd, "dir")
    if startdir == ""
        return
    endif

    let filepattern = input("Search in files matching pattern: ", "*.*") 
    if filepattern == ""
        return
    endif

    try
        execute 'noautocmd lvimgrep /'.pattern.'/gj '.startdir.'/**/'.filepattern
        abo lope
    catch /.*/
        echohl WarningMsg | echo "Not found: ".pattern | echohl None
    endtry
endfun "}}} 

function! helpers#synstac()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! helpers#ToggleRelativeAbsoluteNumber()
    if !&number && !&relativenumber
        set number
        set relativenumber
    elseif &relativenumber
        set norelativenumber
        set number
    elseif &number
        set nonumber
    endif
endfunction
