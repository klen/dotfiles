--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is lua file, vim will append your file to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--
-- Lush.hsl provides a number of convenience functions for:
--
--   Relative adjustment: rotate(), saturate(), desaturate(), lighten(), darken()
--                        aliased to ro(), sa() de(), li(), da(), mix(), readable()
--   Overide:             hue(), saturation(), lightness()
--   Access:              .h, .s, .l
--   Coercion:            tostring(), "Concatenation: " .. color

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

---@diagnostic disable: undefined-global

local lush = require "lush"
local hsl = lush.hsl

local total_black = hsl "#000000"
local total_white = hsl "#ffffff"

local foreground = hsl "#c7c7c7"
local background = hsl "#121212"

local eerie_black = hsl "#1c1c1c"
local cocoa_brown = hsl "#262626"
local jet = hsl "#3a3a3a"
local onyx = hsl "#444444"
local dim_gray = hsl "#606060"
local battleship_grey = hsl "#878787"
local cadet_blue = hsl "#bcbcbc"

local dark_red = hsl "#870000"
local fuzzy_wuzzy = hsl "#d75f5f"
local light_pink = hsl "#ffafaf"
local mellow_apricot = hsl "#ffb964"
local mantis = hsl "#5faf5f"
local bud_green = hsl "#87af5f"
local steel_teal = hsl "#5f8787"
local cool_grey = hsl "#8787af"
local iceberg = hsl "#87afd7"
local baby_blue_eyes = hsl "#afd7ff"
local mauve = hsl "#d7afff"

-- TODO: Not used
local brandy = hsl "#d7d787"
-- local blue_sapphire = hsl "#005f87"
-- local midnight = hsl "#5f005f"

local theme = lush(function()

  -- stylua: ignore
  return {
    -- The following are all the Neovim default highlight groups from the docs
    -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
    -- probably style all of these at a bare minimum.
    --
    -- Referenced/linked groups must come before being referenced/lined,
    -- so the order shown ((mostly) alphabetical) is likely
    -- not the order you will end up with.
    --
    -- You can uncomment these and leave them empty to disable any
    -- styling for that group (meaning they mostly get styled as Normal)
    -- or leave them commented to apply vims default colouring or linking.

    Comment       { fg = battleship_grey, gui = "italic" }, -- any comment
    ColorColumn   { bg = total_black }, -- used for the columns set with 'colorcolumn'
    Conceal       { fg = iceberg }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor        { fg = background, bg = baby_blue_eyes }, -- character under the cursor
    lCursor       { Cursor }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM      { Cursor }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorLine    { bg = eerie_black }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn  { CursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    TermCursor    { fg = background, bg = mellow_apricot }, -- cursor in a focused terminal
    TermCursorNC  { TermCursor }, -- cursor in an unfocused terminal
    Directory     { fg = iceberg }, -- directory names (and other special names in listings)
    DiffAdd       { fg = background, bg = mantis }, -- diff mode: Added line |diff.txt|
    DiffChange    { fg = background, bg = iceberg }, -- diff mode: Changed line |diff.txt|
    DiffDelete    { bg = dark_red }, -- diff mode: Deleted line |diff.txt|
    DiffText      { fg = iceberg, bg = total_black }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer   { fg = background }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    ErrorMsg      { bg = dark_red }, -- error messages on the command line
    VertSplit     { fg = battleship_grey, bg = cocoa_brown }, -- the column separating vertically split windows
    FoldColumn    { fg = dim_gray, bg = eerie_black }, -- 'foldcolumn'
    SignColumn    { FoldColumn }, -- column where |signs| are displayed
    Folded        { SignColumn },
    Search        { fg = brandy }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    IncSearch     { fg = background, bg = brandy }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute    { Search }, -- |:substitute| replacement text highlighting
    LineNr        { fg = dim_gray }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr  { fg = foreground }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen    { fg = total_white, bg = cool_grey }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg       { fg = bud_green }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea       { fg = iceberg }, -- Area for messages and cmdline
    -- MsgSeparator  { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg       { fg = bud_green }, -- |more-prompt|
    NonText       { fg = jet }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Whitespace    { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Normal        { bg = background, fg = foreground }, -- normal text
    NormalFloat   { fg = foreground, bg = cocoa_brown }, -- Normal text in floating windows.
    -- NormalNC      { bg = background.lighten(3) }, -- normal text in non-current windows
    Pmenu         { NormalFloat }, -- Popup menu: normal item.
    PmenuSel      { fg = cocoa_brown, bg = foreground }, -- Popup menu: selected item.
    PmenuSbar     { bg = foreground, fg = cocoa_brown }, -- Popup menu: scrollbar.
    PmenuThumb    { VertSplit }, -- Popup menu: Thumb of the scrollbar.
    Question      { fg = mantis }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine  { bg = onyx }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey    { fg = onyx, bg = eerie_black }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad      { fg = total_white, bg = dark_red }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap      { fg = total_black, bg = bud_green }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal    { fg = total_black, bg = iceberg }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare     { fg = total_black, bg = mellow_apricot }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine    { fg = total_black, bg = foreground }, -- status line of current window
    StatusLineNC  { fg = foreground, bg = jet }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine       { fg = total_black, bg = cadet_blue }, -- tab pages line, not active tab page label
    TabLineFill   { fg = battleship_grey }, -- tab pages line, where there are no labels
    TabLineSel    { fg = total_black, bg = foreground }, -- tab pages line, active tab page label
    Title         { fg = mantis }, -- titles for output from ":set all", ":autocmd" etc.
    Visual        { bg = onyx }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg    { fg = fuzzy_wuzzy }, -- warning messages
    WildMenu      { fg = light_pink, bg = cocoa_brown }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant      { fg = fuzzy_wuzzy }, -- (preferred) any constant
    -- Constant      { fg = steel_teal }, -- (preferred) any constant
    String        { fg = bud_green }, --   a string constant: "this is a string"
    StringDelimiter { fg = onyx },
    Character     { Constant }, --  a character constant: 'c', '\n'
    Number        { Constant }, --   a number constant: 234, 0xff
    Boolean       { Constant }, --  a boolean constant: TRUE, false
    Float         { Constant }, --    a floating point constant: 2.3e10

    Identifier    { fg = mauve }, -- (preferred) any variable name
    Function      { fg = mellow_apricot }, -- function name (also: methods for classes)

    Statement     { fg = cool_grey }, -- (preferred) any statement
    Conditional   { Statement }, --  if, then, else, endif, switch, etc.
    Repeat        { Statement }, --   for, do, while, etc.
    Label         { Statement }, --    case, default, etc.
    Operator      { Statement }, -- "sizeof", "+", "*", etc.
    Keyword       { Statement }, --  any other keyword
    Exception     { Statement }, --  try, catch, throw

    PreProc       { Statement }, -- (preferred) generic Preprocessor
    Include       { PreProc }, --  preprocessor #include
    Define        { PreProc }, --   preprocessor #define
    Macro         { PreProc }, --    same as Define
    PreCondit     { PreProc }, --  preprocessor #if, #else, #endif, etc.

    Type          { fg = iceberg }, -- (preferred) int, long, char, etc.
    StorageClass  { Type }, -- static, register, volatile, etc.
    Structure     { Type }, --  struct, union, enum, etc.
    Typedef       { Type }, --  A typedef

    Special       { fg = steel_teal }, -- (preferred) any special symbol
    -- Special       { fg = fuzzy_wuzzy }, -- (preferred) any special symbol
    SpecialChar   { Special }, --  special character in a constant
    Tag           { Special }, --    you can use CTRL-] on this
    Delimiter     { Special }, --  character that needs attention
    SpecialComment { Special }, -- special things inside a comment
    Debug         { Special }, --    debugging statements

    Underlined    { gui = "underline" }, -- (preferred) text that stands out, HTML links
    Bold          { gui = "bold" },
    Italic        { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error         { bg = dark_red }, -- (preferred) any erroneous construct

    Todo          { fg = steel_teal }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    -- LspReferenceText                     { }, -- used for highlighting "text" references
    -- LspReferenceRead                     { }, -- used for highlighting "read" references
    -- LspReferenceWrite                    { }, -- used for highlighting "write" references

    DiagnosticError { fg = fuzzy_wuzzy }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { fg = mellow_apricot }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { fg = iceberg }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticHint { fg = bud_green }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    DiagnosticSignError { fg = total_white, bg = dark_red }, -- Used for "Error" signs in sign column
    DiagnosticSignWarn { fg = total_black, bg = mellow_apricot }, -- Used for "Warning" signs in sign column
    DiagnosticSignInfo { fg = total_black, bg = iceberg }, -- Used for "Information" signs in sign column
    DiagnosticSignHint { fg = total_black, bg = bud_green }, -- Used for "Hint" signs in sign column

    DiagnosticVirtualTextError { DiagnosticError }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn { DiagnosticWarn }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo { DiagnosticInfo }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint { DiagnosticHint }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError { gui="undercurl", sp = dark_red }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn { gui="undercurl", sp = mellow_apricot }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo { gui="undercurl", sp = iceberg }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint { gui="undercurl", sp = bud_green }, -- Used to underline "Hint" diagnostics

    DiagnosticFloatingError { DiagnosticError }, -- Used to color "Error" diagnostic messages in diagnostics float
    DiagnosticFloatingWarn  { DiagnosticWarn }, -- Used to color "Warning" diagnostic messages in diagnostics float
    DiagnosticFloatingInfo  { DiagnosticInfo }, -- Used to color "Information" diagnostic messages in diagnostics float
    DiagnosticFloatingHint  { DiagnosticHint }, -- Used to color "Hint" diagnostic messages in diagnostics float

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    -- TSAnnotation         { },    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSAttribute          { },    -- (unstable) TODO: docs
    TSBoolean           { Constant },    -- For booleans.
    TSCharacter         { Constant },    -- For characters.
    TSFloat             { Constant },    -- For floats.
    TSNumber            { Constant },    -- For all numbers
    TSComment           { Comment },    -- For comment blocks.
    TSConstructor       { Structure }, -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    TSConditional       { Conditional },    -- For keywords related to conditionnals.
    TSConstant          { Normal, gui = "italic" }, -- For constants
    TSConstBuiltin      { Constant, gui = "italic" }, -- For constant that are built in the language: `nil` in Lua.
    TSConstMacro        { TSConstBuiltin },    -- For constants that are defined by macros: `NULL` in C.
    TSError             { Normal },    -- For syntax/parser errors.
    TSException         { Statement },    -- For exception related keywords.
    TSField             { Normal }, -- For fields.
    TSFunction          { Function },    -- For function (calls and definitions).
    TSFuncBuiltin       { TSFunction }, -- For builtin functions: `table.insert` in Lua.
    TSFuncMacro         { TSFunction },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude           { Statement },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword           { Statement },    -- For keywords that don't fall in previous categories.
    TSKeywordFunction   { Statement },    -- For keywords used to define a fuction.
    TSLabel             { Statement },    -- For labels: `label:` in C and `:label:` in Lua.
    TSMethod            { fg = mellow_apricot.lighten(10) }, -- For method calls and definitions.
    TSNamespace         { TSConstMacro },    -- For identifiers referring to modules and namespaces.
    TSOperator          { Normal },    -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter         { Normal }, -- For parameters of a function.
    TSParameterReference { TSParameter },    -- For references to parameters of a function.
    TSProperty          { TSField }, -- Same as `TSField`.
    TSPunctDelimiter    { Normal }, -- For delimiters ie: `.`
    TSPunctBracket      { Normal }, -- For brackets and parens.
    TSPunctSpecial      { Normal }, -- For special punctutation that does not fall in the catagories before.
    TSRepeat            { TSKeyword },    -- For keywords related to loops.
    TSString            { String },    -- For strings.
    TSStringRegex       { TSString },    -- For regexes.
    -- TSStringEscape       { },    -- For escape characters within a string.
    -- TSSymbol             { },    -- For identifiers referring to symbols or atoms.
    TSType              { Structure }, -- For types.
    TSTypeBuiltin       { Operator }, -- For builtin types.
    TSVariable          { Normal },    -- Any variable name that does not have another highlight.
    TSVariableBuiltin   { Normal, gui = "bold" }, -- Variable names that are defined by the languages, like `this` or `self`.

    -- TSTag                { },    -- Tags like html tag names.
    -- TSTagDelimiter       { },    -- Tag delimiter like `<` `>` `/`
    -- TSText               { },    -- For strings considered text in a markup language.
    -- TSEmphasis           { },    -- For text to be represented with emphasis.
    -- TSUnderline          { },    -- For text to be represented with an underline.
    -- TSStrike             { },    -- For strikethrough text.
    -- TSTitle              { },    -- Text that is part of a title.
    -- TSLiteral            { },    -- Literal text.
    -- TSURI                { },    -- Any URI like a link or email.

    TSNote              { DiagnosticInfo },    -- NOTE: docs
    TSWarning           { DiagnosticWarn },    -- TODO: docs
    TSDanger            { DiagnosticError },    -- XXX: docs

    -- NvimTree Hightlights
		NvimTreeRootFolder { fg = cool_grey },
    NvimTreeOpenedFile { fg = mantis },
    NvimTreeOpenedFolderName { Directory },
    NvimTreeSpecialFile { fg = steel_teal },

    -- SymbolsOutline
    FocusedSymbol { Search, gui="none" },

    -- GitSigns
    GitSignsAdd { fg = mantis},
    GitSignsChange { fg = iceberg },
    GitSignsDelete { fg = fuzzy_wuzzy},

    -- IndentBlanklineIndent
    IndentBlanklineChar { fg=cocoa_brown, gui="nocombine" },
  }
end)

vim.opt.background = "dark"
vim.g.colors_name = "covid19"
lush(theme)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
