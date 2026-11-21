" Global LSP options

scriptencoding utf-8

if exists('*g:LspOptionsSet')
    call g:LspOptionsSet(#{
        \ autoComplete: v:true,
        \ autoHighlightDiags: v:true,
        \ completionMatcher: 'fuzzy',
        \ ignoreMissingServer: v:true,
        \ popupBorder: v:true,
        \ showDiagWithSign: v:true,
        \ showInlayHints: v:false,
        \ useQuickfixForLocations: v:true,
        \ })
endif
