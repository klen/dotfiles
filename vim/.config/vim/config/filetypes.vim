" Extra filetype mappings

scriptencoding utf-8

augroup filetypes
    autocmd!
    " Alloy uses the HCL filetype
    autocmd BufNewFile,BufRead *.alloy setfiletype hcl
augroup END
