" covid19
" (lush theme, same palette and groups)

hi clear
if exists('syntax_on')
    syntax reset
endif
set background=dark
let g:colors_name = 'covid19'

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Palette
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

let s:black        = '#000000'
let s:white        = '#ffffff'
let s:foreground   = '#c7c7c7'
let s:background   = '#121212'
let s:eerie_black  = '#1c1c1c'
let s:cocoa_brown  = '#262626'
let s:jet          = '#3a3a3a'
let s:onyx         = '#444444'
let s:dim_gray     = '#606060'
let s:battleship   = '#878787'
let s:dark_red     = '#870000'
let s:fuzzy_wuzzy  = '#d75f5f'
let s:light_pink   = '#ffafaf'
let s:mellow       = '#ffb964'
let s:mantis       = '#5faf5f'
let s:bud_green    = '#87af5f'
let s:steel_teal   = '#5f8787'
let s:cool_grey    = '#8787af'
let s:iceberg      = '#87afd7'
let s:baby_blue    = '#afd7ff'
let s:mauve        = '#d7afff'
let s:brandy       = '#d7d787'

let s:cterm = {
    \ s:black: 16, s:white: 231,
    \ s:foreground: 251, s:background: 233,
    \ s:eerie_black: 234, s:cocoa_brown: 235,
    \ s:jet: 237, s:onyx: 238,
    \ s:dim_gray: 241, s:battleship: 246,
    \ s:dark_red: 88, s:fuzzy_wuzzy: 167,
    \ s:light_pink: 217, s:mellow: 215,
    \ s:mantis: 71, s:bud_green: 107,
    \ s:steel_teal: 66, s:cool_grey: 103,
    \ s:iceberg: 110, s:baby_blue: 153,
    \ s:mauve: 183, s:brandy: 186,
    \ }

function! s:hi(group, fg, bg, attr, ...) abort
    let cmd = 'highlight ' . a:group
    let cmd .= ' guifg=' . (empty(a:fg) ? 'NONE' : a:fg)
    let cmd .= ' guibg=' . (empty(a:bg) ? 'NONE' : a:bg)
    let cmd .= ' gui=' . (empty(a:attr) ? 'NONE' : a:attr)
    let cmd .= ' ctermfg=' . (has_key(s:cterm, a:fg) ? s:cterm[a:fg] : 'NONE')
    let cmd .= ' ctermbg=' . (has_key(s:cterm, a:bg) ? s:cterm[a:bg] : 'NONE')
    let cmd .= ' cterm=' . (empty(a:attr) ? 'NONE' : a:attr)
    let cmd .= ' term=NONE'
    if a:0 && !empty(a:1)
        let cmd .= ' guisp=' . a:1
    endif
    execute cmd
endfunction

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" UI / Editor
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

call s:hi('Normal',       s:foreground, s:background, '')
call s:hi('NormalNC',     s:foreground, s:background, '')
call s:hi('NormalFloat',  s:foreground, s:background, '')

call s:hi('ColorColumn',  '', s:black, '')
call s:hi('Conceal',      s:iceberg, '', '')
call s:hi('Cursor',       s:background, s:baby_blue, '')
call s:hi('CursorIM',     s:background, s:baby_blue, '')
call s:hi('CursorLine',   '', s:eerie_black, '')
call s:hi('CursorColumn', '', s:eerie_black, '')
call s:hi('CursorLineNr', s:foreground, '', '')
call s:hi('LineNr',       s:dim_gray, '', '')
call s:hi('SignColumn',   s:dim_gray, s:eerie_black, '')
call s:hi('FoldColumn',   s:dim_gray, s:eerie_black, '')
call s:hi('Folded',       s:dim_gray, s:eerie_black, '')
call s:hi('lCursor',      s:background, s:baby_blue, '')
call s:hi('TermCursor',   s:background, s:mellow, '')
call s:hi('TermCursorNC', s:background, s:mellow, '')

call s:hi('EndOfBuffer',  s:background, '', '')
call s:hi('NonText',      s:jet, '', '')
call s:hi('Whitespace',   s:jet, '', '')
call s:hi('SpecialKey',   s:onyx, s:eerie_black, '')
call s:hi('Directory',    s:iceberg, '', '')

call s:hi('StatusLine',   s:black, s:foreground, '')
call s:hi('StatusLineNC', s:foreground, s:jet, '')
call s:hi('TabLineFill',  '', s:jet, '')
call s:hi('TabLine',      s:battleship, s:jet, '')
call s:hi('TabLineSel',   s:white, s:jet, 'bold')
call s:hi('VertSplit',    s:battleship, s:cocoa_brown, '')
call s:hi('WinSeparator', s:battleship, s:cocoa_brown, '')

call s:hi('ErrorMsg',     s:foreground, s:dark_red, '')
call s:hi('WarningMsg',   s:fuzzy_wuzzy, '', '')
call s:hi('ModeMsg',      s:bud_green, '', '')
call s:hi('MoreMsg',      s:bud_green, '', '')
call s:hi('Question',     s:mantis, '', '')
call s:hi('Title',        s:mantis, '', '')

call s:hi('Pmenu',        s:foreground, '', '')
call s:hi('PmenuSel',     s:cocoa_brown, s:foreground, '')
call s:hi('PmenuSbar',    s:cocoa_brown, s:foreground, '')
call s:hi('PmenuThumb',   s:battleship, s:cocoa_brown, '')
call s:hi('WildMenu',     s:light_pink, s:cocoa_brown, '')
call s:hi('QuickFixLine', '', s:onyx, '')

call s:hi('Visual',       '', s:onyx, '')
call s:hi('VisualNOS',    '', s:onyx, '')
call s:hi('Search',       s:brandy, '', '')
call s:hi('IncSearch',    s:background, s:brandy, '')
call s:hi('Substitute',   s:brandy, '', '')
call s:hi('MatchParen',   s:white, s:cool_grey, '')

call s:hi('DiffAdd',      s:mantis, '', '')
call s:hi('DiffChange',   s:mellow, '', '')
call s:hi('DiffDelete',   s:fuzzy_wuzzy, '', '')
call s:hi('DiffText',     s:brandy, s:black, '')

call s:hi('SpellBad',     s:white, s:dark_red, '')
call s:hi('SpellCap',     s:black, s:bud_green, '')
call s:hi('SpellLocal',   s:black, s:iceberg, '')
call s:hi('SpellRare',    s:black, s:mellow, '')

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" Syntax
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

call s:hi('Comment',        s:battleship, '', 'italic')
call s:hi('Constant',       s:fuzzy_wuzzy, '', '')
call s:hi('String',         s:bud_green, '', '')
call s:hi('StringDelimiter', s:onyx, '', '')
call s:hi('Character',      s:fuzzy_wuzzy, '', '')
call s:hi('Number',         s:fuzzy_wuzzy, '', '')
call s:hi('Boolean',        s:fuzzy_wuzzy, '', '')
call s:hi('Float',          s:fuzzy_wuzzy, '', '')

call s:hi('Identifier',     s:mauve, '', '')
call s:hi('Function',       s:iceberg, '', '')
call s:hi('FunctionCall',   s:mellow, '', '')

call s:hi('Statement',      s:cool_grey, '', '')
call s:hi('Conditional',    s:cool_grey, '', '')
call s:hi('Label',          s:cool_grey, '', '')
call s:hi('Operator',       s:foreground, '', '')
call s:hi('Keyword',        s:cool_grey, '', '')
call s:hi('Repeat',         s:cool_grey, '', '')
call s:hi('Exception',      s:cool_grey, '', '')

call s:hi('PreProc',        s:cool_grey, '', '')
call s:hi('Include',        s:cool_grey, '', '')
call s:hi('Define',         s:cool_grey, '', '')
call s:hi('Macro',          s:cool_grey, '', '')
call s:hi('PreCondit',      s:cool_grey, '', '')

call s:hi('Type',           s:iceberg, '', '')
call s:hi('StorageClass',   s:iceberg, '', '')
call s:hi('Structure',      s:iceberg, '', '')
call s:hi('Typedef',        s:iceberg, '', '')

call s:hi('Special',        s:steel_teal, '', '')
call s:hi('SpecialChar',    s:steel_teal, '', '')
call s:hi('Tag',            s:steel_teal, '', '')
call s:hi('Delimiter',      s:foreground, '', '')
call s:hi('SpecialComment', s:steel_teal, '', '')
call s:hi('Debug',          s:steel_teal, '', '')

call s:hi('Underlined',     '', '', 'underline')
call s:hi('Bold',           '', '', 'bold')
call s:hi('Italic',         '', '', 'italic')
call s:hi('Error',          '', s:dark_red, '')
call s:hi('Todo',           s:steel_teal, '', '')

" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
" LSP / Diagnostics (yegappan/lsp + standard Diagnostic groups)
" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

call s:hi('DiagnosticError', s:fuzzy_wuzzy, '', '')
call s:hi('DiagnosticWarn',  s:mellow, '', '')
call s:hi('DiagnosticInfo',  s:iceberg, '', '')
call s:hi('DiagnosticHint',  s:bud_green, '', '')

call s:hi('LspDiagSignErrorText',   s:white, s:dark_red, '')
call s:hi('LspDiagSignWarningText', s:black, s:mellow, '')
call s:hi('LspDiagSignInfoText',    s:black, s:iceberg, '')
call s:hi('LspDiagSignHintText',    s:black, s:bud_green, '')

call s:hi('LspDiagInlineError',   '', '', 'undercurl', s:dark_red)
call s:hi('LspDiagInlineWarning', '', '', 'undercurl', s:mellow)
call s:hi('LspDiagInlineInfo',    '', '', 'undercurl', s:iceberg)
call s:hi('LspDiagInlineHint',    '', '', 'undercurl', s:bud_green)

call s:hi('LspDiagVirtualTextError',   s:fuzzy_wuzzy, '', '')
call s:hi('LspDiagVirtualTextWarning', s:mellow, '', '')
call s:hi('LspDiagVirtualTextInfo',    s:iceberg, '', '')
call s:hi('LspDiagVirtualTextHint',    s:bud_green, '', '')

call s:hi('DiagnosticUnderlineError', '', '', 'undercurl', s:dark_red)
call s:hi('DiagnosticUnderlineWarn',  '', '', 'undercurl', s:mellow)
call s:hi('DiagnosticUnderlineInfo',  '', '', 'undercurl', s:iceberg)
call s:hi('DiagnosticUnderlineHint',  '', '', 'undercurl', s:bud_green)

call s:hi('DiagnosticVirtualTextError', s:fuzzy_wuzzy, '', '')
call s:hi('DiagnosticVirtualTextWarn',  s:mellow, '', '')
call s:hi('DiagnosticVirtualTextInfo',  s:iceberg, '', '')
call s:hi('DiagnosticVirtualTextHint',  s:bud_green, '', '')

call s:hi('DiagnosticSignError', s:white, s:dark_red, '')
call s:hi('DiagnosticSignWarn',  s:black, s:mellow, '')
call s:hi('DiagnosticSignInfo',  s:black, s:iceberg, '')
call s:hi('DiagnosticSignHint',  s:black, s:bud_green, '')
