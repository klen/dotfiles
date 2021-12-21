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

local grey_one = hsl "#1c1c1c"
local cocoa_brown = hsl "#262626"
local gravel = hsl "#3a3a3a"
local bright_grey = hsl "#444444"
local scorpion = hsl "#606060"
local grey = hsl "#878787"
local cadet_blue = hsl "#bcbcbc"
local silver = hsl "#c6c6c6"
local grey_two = hsl "#eeeeee"

local dark_red = hsl "#870000"
local raw_sienna = hsl "#d75f5f"
local wewak = hsl "#ffafaf"
local orange = hsl "#F49F0A"
local mantis = hsl "#5faf5f"
local bud_green = hsl "#87af5f"
local brandy = hsl "#d7d787"
local hoki = hsl "#5f8787"
local dark_blue = hsl "#0000d7"
local calypso = hsl "#005f87"
local ship_cove = hsl "#8787af"
local morning_glory = hsl "#87afd7"
local perano = hsl "#afd7ff"
local ripe_plum = hsl "#5f005f"
local biloba_flower = hsl "#d7afff"

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

    Comment       { fg = grey, gui = "italic" }, -- any comment
    ColorColumn   { bg = total_black }, -- used for the columns set with 'colorcolumn'
    Conceal       { fg = morning_glory }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor        { fg = background, bg = perano }, -- character under the cursor
    lCursor       { Cursor }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn  { bg = grey_one }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine    { bg = grey_one }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory     { fg = brandy }, -- directory names (and other special names in listings)
    DiffAdd       { fg = background, bg = mantis }, -- diff mode: Added line |diff.txt|
    DiffChange    { fg = background, bg = morning_glory }, -- diff mode: Changed line |diff.txt|
    DiffDelete    { bg = dark_red }, -- diff mode: Deleted line |diff.txt|
    DiffText      { fg = morning_glory, bg = total_black }, -- diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer   { fg = background }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    ErrorMsg      { bg = dark_red }, -- error messages on the command line
    VertSplit     { fg = grey, bg = cocoa_brown }, -- the column separating vertically split windows
    FoldColumn    { fg = scorpion, bg = grey_one }, -- 'foldcolumn'
    SignColumn    { fg = foreground, bg = gravel }, -- column where |signs| are displayed
    Folded        { SignColumn },
    -- IncSearch    { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr        { fg = scorpion }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr  { fg = silver }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen    { fg = total_white, bg = ship_cove }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg       { fg = bud_green }, -- |more-prompt|
    NonText       { fg = scorpion }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal        { bg = background, fg = foreground }, -- normal text
    -- NormalFloat  { }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    Pmenu         { fg = foreground, bg = cocoa_brown }, -- Popup menu: normal item.
    PmenuSel      { fg = foreground }, -- Popup menu: selected item.
    PmenuSbar     { bg = foreground, fg = cocoa_brown }, -- Popup menu: scrollbar.
    -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
    Question      { fg = mantis }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine  { bg = bright_grey }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search        { fg = wewak, gui = "underline" }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey    { fg = bright_grey, bg = grey_one }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad      { bg = dark_red }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap      { bg = dark_blue }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal    { bg = calypso }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare     { bg = ripe_plum }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine    { fg = total_black, bg = silver }, -- status line of current window
    StatusLineNC  { fg = total_white, bg = gravel }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine       { fg = total_black, bg = cadet_blue }, -- tab pages line, not active tab page label
    TabLineFill   { fg = grey }, -- tab pages line, where there are no labels
    TabLineSel    { fg = total_black, bg = grey_two }, -- tab pages line, active tab page label
    Title         { fg = mantis }, -- titles for output from ":set all", ":autocmd" etc.
    Visual        { bg = bright_grey }, -- Visual mode selection
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg    { fg = raw_sienna }, -- warning messages
    -- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    WildMenu      { fg = wewak, bg = cocoa_brown }, -- current match in 'wildmenu' completion

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant      { fg = raw_sienna }, -- (preferred) any constant
    String        { fg = bud_green }, --   a string constant: "this is a string"
    StringDelimiter { fg = bright_grey },
    Character     { Constant }, --  a character constant: 'c', '\n'
    Number        { Constant }, --   a number constant: 234, 0xff
    Boolean       { Constant }, --  a boolean constant: TRUE, false
    Float         { Constant }, --    a floating point constant: 2.3e10

    Identifier    { fg = biloba_flower }, -- (preferred) any variable name
    Function      { fg = orange }, -- function name (also: methods for classes)

    Statement     { fg = ship_cove }, -- (preferred) any statement
    Conditional   { Statement }, --  if, then, else, endif, switch, etc.
    Repeat        { Statement }, --   for, do, while, etc.
    Label         { Statement }, --    case, default, etc.
    Operator      { Statement }, -- "sizeof", "+", "*", etc.
    Keyword       { Statement }, --  any other keyword
    Exception     { Statement }, --  try, catch, throw

    PreProc       { fg = morning_glory }, -- (preferred) generic Preprocessor
    -- Include        { }, --  preprocessor #include
    -- Define         { }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

    Type          { fg = morning_glory }, -- (preferred) int, long, char, etc.
    StorageClass  { Type }, -- static, register, volatile, etc.
    Structure     { Type }, --  struct, union, enum, etc.
    Typedef       { Type }, --  A typedef

    Special       { fg = bud_green }, -- (preferred) any special symbol
    -- SpecialChar    { }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    Delimiter     { fg = hoki }, --  character that needs attention
    -- SpecialComment { }, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    Underlined    { gui = "underline" }, -- (preferred) text that stands out, HTML links
    Bold          { gui = "bold" },
    Italic        { gui = "italic" },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error         { bg = dark_red }, -- (preferred) any erroneous construct

    Todo          { fg = silver }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client. Some other LSP clients may
    -- use these groups, or use their own. Consult your LSP client's
    -- documentation.

    -- LspReferenceText                     { }, -- used for highlighting "text" references
    -- LspReferenceRead                     { }, -- used for highlighting "read" references
    -- LspReferenceWrite                    { }, -- used for highlighting "write" references

    DiagnosticError { fg = raw_sienna }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { fg = orange }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { fg = morning_glory }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticHint { fg = bud_green }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

    DiagnosticSignError { fg = total_white, bg = dark_red }, -- Used for "Error" signs in sign column
    DiagnosticSignWarn { fg = total_black, bg = orange }, -- Used for "Warning" signs in sign column
    DiagnosticSignInfo { fg = total_black, bg = morning_glory }, -- Used for "Information" signs in sign column
    DiagnosticSignHint { fg = total_black, bg = bud_green }, -- Used for "Hint" signs in sign column

    DiagnosticVirtualTextError { DiagnosticError }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarn { DiagnosticWarn }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInfo { DiagnosticInfo }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint { DiagnosticHint }, -- Used for "Hint" diagnostic virtual text

    DiagnosticUnderlineError { guisp = dark_red }, -- Used to underline "Error" diagnostics
    DiagnosticUnderlineWarn { guisp = orange }, -- Used to underline "Warning" diagnostics
    DiagnosticUnderlineInfo { guisp = morning_glory }, -- Used to underline "Information" diagnostics
    DiagnosticUnderlineHint { guisp = bud_green }, -- Used to underline "Hint" diagnostics

    -- DiagnosticFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
    -- DiagnosticFloatingWarn        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
    -- DiagnosticFloatingInfo    { }, -- Used to color "Information" diagnostic messages in diagnostics float
    -- DiagnosticFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float

    -- These groups are for the neovim tree-sitter highlights.
    -- As of writing, tree-sitter support is a WIP, group names may change.
    -- By default, most of these groups link to an appropriate Vim group,
    -- TSError -> Error for example, so you do not have to define these unless
    -- you explicitly want to support Treesitter's improved syntax awareness.

    -- TSAnnotation         { };    -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    -- TSAttribute          { };    -- (unstable) TODO: docs
    TSBoolean           { Constant };    -- For booleans.
    TSCharacter         { Constant };    -- For characters.
    TSFloat             { Constant };    -- For floats.
    TSNumber            { Constant };    -- For all numbers
    TSComment           { Comment };    -- For comment blocks.
    -- TSConstructor       { Function }, -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    TSConstructor       { Structure }, -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
    -- TSConditional        { };    -- For keywords related to conditionnals.
    TSConstant          { Normal, gui = "bold" }, -- For constants
    TSConstBuiltin      { Constant, gui = "bold" }, -- For constant that are built in the language: `nil` in Lua.
    -- TSConstMacro         { };    -- For constants that are defined by macros: `NULL` in C.
    -- TSError              { };    -- For syntax/parser errors.
    -- TSException          { };    -- For exception related keywords.
    TSField             { Normal }, -- For fields.
    TSFunction          { Function },    -- For function (calls and definitions).
    TSFuncBuiltin       { Function, gui = "bold" }, -- For builtin functions: `table.insert` in Lua.
    -- TSFuncMacro          { };    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
    TSInclude           { Statement };    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSKeyword           { Statement };    -- For keywords that don't fall in previous categories.
    TSKeywordFunction   { Statement };    -- For keywords used to define a fuction.
    TSLabel             { Statement };    -- For labels: `label:` in C and `:label:` in Lua.
    TSMethod            { fg = orange.lighten(10) }, -- For method calls and definitions.
    -- TSNamespace          { };    -- For identifiers referring to modules and namespaces.
    -- TSNone               { };    -- TODO: docs
    -- TSOperator           { };    -- For any operator: `+`, but also `->` and `*` in C.
    TSParameter         { Normal }, -- For parameters of a function.
    -- TSParameterReference { };    -- For references to parameters of a function.
    TSProperty          { TSField }, -- Same as `TSField`.
    TSPunctDelimiter    { Normal }, -- For delimiters ie: `.`
    TSPunctBracket      { Normal }, -- For brackets and parens.
    TSPunctSpecial      { Normal }, -- For special punctutation that does not fall in the catagories before.
    TSRepeat            { TSKeyword };    -- For keywords related to loops.
    TSString            { String };    -- For strings.
    TSStringRegex       { TSString };    -- For regexes.
    -- TSStringEscape       { };    -- For escape characters within a string.
    -- TSSymbol             { };    -- For identifiers referring to symbols or atoms.
    TSType              { Structure }, -- For types.
    TSTypeBuiltin       { Operator }, -- For builtin types.
    -- TSVariable           { };    -- Any variable name that does not have another highlight.
    TSVariableBuiltin   { Normal, gui = "bold" }, -- Variable names that are defined by the languages, like `this` or `self`.

    -- TSTag                { };    -- Tags like html tag names.
    -- TSTagDelimiter       { };    -- Tag delimiter like `<` `>` `/`
    -- TSText               { };    -- For strings considered text in a markup language.
    -- TSEmphasis           { };    -- For text to be represented with emphasis.
    -- TSUnderline          { };    -- For text to be represented with an underline.
    -- TSStrike             { };    -- For strikethrough text.
    -- TSTitle              { };    -- Text that is part of a title.
    -- TSLiteral            { };    -- Literal text.
    -- TSURI                { };    -- Any URI like a link or email.

    pythonClass         { Structure },
    -- pythonStatement      { };
    -- pythonFunction       { };
    -- pythonCo

    NvimTreeOpenedFile { fg = mantis },

  }
end)

vim.opt.background = "dark"
vim.g.colors_name = "covid19"
lush(theme)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
