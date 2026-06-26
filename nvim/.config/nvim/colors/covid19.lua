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

local ok, lush = pcall(require, "lush")
if not ok then return end

local hsl = lush.hsl

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Palette
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local total_black = hsl("#000000")
local total_white = hsl("#ffffff")

local foreground = hsl("#c7c7c7")
local background = hsl("#121212")

local eerie_black = hsl("#1c1c1c")
local cocoa_brown = hsl("#262626")
local jet = hsl("#3a3a3a")
local onyx = hsl("#444444")
local dim_gray = hsl("#606060")
local battleship_grey = hsl("#878787")

local dark_red = hsl("#870000")
local fuzzy_wuzzy = hsl("#d75f5f")
local light_pink = hsl("#ffafaf")
local mellow_apricot = hsl("#ffb964")
local mantis = hsl("#5faf5f")
local bud_green = hsl("#87af5f")
local steel_teal = hsl("#5f8787")
local cool_grey = hsl("#8787af")
local iceberg = hsl("#87afd7")
local baby_blue_eyes = hsl("#afd7ff")
local mauve = hsl("#d7afff")
local brandy = hsl("#d7d787")

-- TODO: Not used
local blue_sapphire = hsl "#005f87"
local midnight = hsl "#5f005f"
local cadet_blue = hsl("#bcbcbc")

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Theme
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym

  -- stylua: ignore start
  return {

    -- =========================================================================
    --  UI / Editor
    -- =========================================================================

    Normal { bg = background, fg = foreground },          -- normal text
    NormalFloat { fg = foreground },                      -- normal text in floating windows
    -- NormalNC     { bg = background.lighten(3) },         -- normal text in non-current windows

    ColorColumn { bg = total_black },                         -- columns set with 'colorcolumn'
    Conceal { fg = iceberg },                                 -- placeholder chars for concealed text
    Cursor { fg = background, bg = baby_blue_eyes },          -- character under cursor
    CursorIM { Cursor },                                      -- cursor in IME mode
    CursorLine { bg = eerie_black },                          -- screen-line at cursor
    CursorColumn { CursorLine },                              -- screen-column at cursor
    CursorLineNr { fg = foreground },                         -- line number on cursor line
    LineNr { fg = dim_gray },                                 -- line number
    SignColumn { fg = dim_gray, bg = eerie_black },           -- sign column
    FoldColumn { fg = dim_gray, bg = eerie_black },           -- fold column
    Folded { fg = dim_gray, bg = eerie_black },
    lCursor { Cursor },
    TermCursor { fg = background, bg = mellow_apricot },
    TermCursorNC { TermCursor },

    EndOfBuffer { fg = background },                 -- ~ filler lines
    NonText { fg = jet },                            -- @ and showbreak chars
    Whitespace { fg = jet },                         -- listchars whitespace
    SpecialKey { fg = onyx, bg = eerie_black },      -- unprintable chars

    Directory { fg = iceberg },                      -- directory names

    -- Statusline / Tabline
    StatusLine { fg = total_black, bg = foreground },
    StatusLineNC { fg = foreground, bg = jet },
    TabLineFill { bg = jet },
    TabLine { fg = battleship_grey, bg = jet },
    TabLineSel { fg = total_white, bg = jet, gui = "bold" },

    -- Splits
    VertSplit { fg = battleship_grey, bg = cocoa_brown },

    -- Messages
    ErrorMsg { bg = dark_red },
    WarningMsg { fg = fuzzy_wuzzy },
    ModeMsg { fg = bud_green },
    MoreMsg { fg = bud_green },
    Question { fg = mantis },
    Title { fg = mantis },
    -- MsgArea      { fg = iceberg },
    -- MsgSeparator { },

    -- Popup / Completion menu
    Pmenu { fg = foreground },                             -- normal item
    PmenuSel { fg = cocoa_brown, bg = foreground },        -- selected item
    PmenuSbar { bg = foreground, fg = cocoa_brown },       -- scrollbar
    PmenuThumb { fg = battleship_grey, bg = cocoa_brown },

    -- Wildmenu
    WildMenu { fg = light_pink, bg = cocoa_brown },

    -- Quickfix
    QuickFixLine { bg = onyx },

    -- Visual / Selection
    Visual { bg = onyx },
    -- VisualNOS     { },

    -- Search
    Search { fg = brandy },
    IncSearch { fg = background, bg = brandy },
    Substitute { fg = brandy },

    -- Matching
    MatchParen { fg = total_white, bg = cool_grey },

    -- Diff
    DiffAdd { fg = mantis },
    DiffChange { fg = mellow_apricot },
    DiffDelete { fg = fuzzy_wuzzy },
    DiffText { fg = brandy, bg = total_black },

    -- Spelling
    SpellBad { fg = total_white, bg = dark_red },
    SpellCap { fg = total_black, bg = bud_green },
    SpellLocal { fg = total_black, bg = iceberg },
    SpellRare { fg = total_black, bg = mellow_apricot },

    -- =========================================================================
    --  Syntax Highlighting
    -- =========================================================================

    Comment { fg = battleship_grey, gui = "italic" },

    -- Constants
    Constant { fg = fuzzy_wuzzy },
    String { fg = bud_green },
    StringDelimiter { fg = onyx },
    Character { fg = fuzzy_wuzzy },
    Number { fg = fuzzy_wuzzy },
    Boolean { fg = fuzzy_wuzzy },
    Float { fg = fuzzy_wuzzy },

    -- Identifiers
    Identifier { fg = mauve },
    Function { fg = iceberg },
    FunctionCall { fg = mellow_apricot },

    -- Statements / Keywords
    Statement { fg = cool_grey },
    Conditional { fg = cool_grey },
    Label { fg = cool_grey },
    Operator { fg = foreground },
    Keyword { fg = cool_grey },
    Repeat { fg = cool_grey },
    Exception { fg = cool_grey },

    -- Preprocessor
    PreProc { fg = cool_grey },
    Include { fg = cool_grey },
    Define { fg = cool_grey },
    Macro { fg = cool_grey },
    PreCondit { fg = cool_grey },

    -- Types
    Type { fg = iceberg },
    StorageClass { fg = iceberg },
    Structure { fg = iceberg },
    Typedef { fg = iceberg },

    -- Special
    Special { fg = steel_teal },
    SpecialChar { fg = steel_teal },
    Tag { fg = steel_teal },
    Delimiter { fg = foreground },
    SpecialComment { fg = steel_teal },
    Debug { fg = steel_teal },

    -- Text style
    Underlined { gui = "underline" },
    Bold { gui = "bold" },
    Italic { gui = "italic" },

    -- Misc
    Error { bg = dark_red },
    Todo { fg = steel_teal },
    -- Ignore        { },

    -- =========================================================================
    --  LSP / Diagnostics
    -- =========================================================================

    DiagnosticError { fg = fuzzy_wuzzy },
    DiagnosticWarn { fg = mellow_apricot },
    DiagnosticInfo { fg = iceberg },
    DiagnosticHint { fg = bud_green },

    DiagnosticSignError { fg = total_white, bg = dark_red },
    DiagnosticSignWarn { fg = total_black, bg = mellow_apricot },
    DiagnosticSignInfo { fg = total_black, bg = iceberg },
    DiagnosticSignHint { fg = total_black, bg = bud_green },

    DiagnosticVirtualTextError { fg = fuzzy_wuzzy },
    DiagnosticVirtualTextWarn { fg = mellow_apricot },
    DiagnosticVirtualTextInfo { fg = iceberg },
    DiagnosticVirtualTextHint { fg = bud_green },

    DiagnosticUnderlineError { gui = "undercurl", sp = dark_red },
    DiagnosticUnderlineWarn { gui = "undercurl", sp = mellow_apricot },
    DiagnosticUnderlineInfo { gui = "undercurl", sp = iceberg },
    DiagnosticUnderlineHint { gui = "undercurl", sp = bud_green },

    DiagnosticFloatingError { fg = fuzzy_wuzzy },
    DiagnosticFloatingWarn { fg = mellow_apricot },
    DiagnosticFloatingInfo { fg = iceberg },
    DiagnosticFloatingHint { fg = bud_green },

    -- LspReferenceText                  { },
    -- LspReferenceRead                  { },
    -- LspReferenceWrite                 { },

    -- =========================================================================
    --  Treesitter
    -- =========================================================================

    sym "@annotation" { fg = cool_grey },
    sym "@attribute" {},
    sym "@boolean" { fg = fuzzy_wuzzy },
    sym "@character" { fg = fuzzy_wuzzy },
    sym "@character.printf" { fg = steel_teal },
    sym "@character.special" { fg = steel_teal },
    sym "@comment" { fg = battleship_grey, gui = "italic" },
    sym "@comment.error" { fg = battleship_grey, gui = "italic" },
    sym "@comment.hint" { fg = bud_green },
    sym "@comment.note" { fg = battleship_grey, gui = "bold" },
    sym "@comment.todo" { fg = iceberg },
    sym "@comment.warning" { fg = mellow_apricot },
    sym "@constant" { fg = foreground, gui = "italic" },
    sym "@constant.builtin" { fg = fuzzy_wuzzy, gui = "italic" },
    sym "@constant.macro" { fg = cool_grey, gui = "italic" },
    sym "@constructor" { fg = mellow_apricot },
    sym "@constructor.tsx" { fg = iceberg },
    sym "@diff.delta" { fg = mellow_apricot },
    sym "@diff.minus" { fg = fuzzy_wuzzy },
    sym "@diff.plus" { fg = mantis },
    sym "@function" { fg = iceberg },
    sym "@function.builtin" { fg = iceberg },
    sym "@function.macro" { fg = iceberg },
    sym "@function.call" { fg = mellow_apricot },
    sym "@function.method" { fg = iceberg },
    sym "@function.method.call" { fg = mellow_apricot },
    sym "@operator" { fg = foreground },
    sym "@punctuation.bracket" { fg = foreground },
    sym "@punctuation.delimiter" { fg = foreground },
    sym "@punctuation.special" { fg = foreground },
    sym "@number" { fg = fuzzy_wuzzy },
    sym "@number.float" { fg = fuzzy_wuzzy },
    sym "@keyword" { fg = cool_grey },
    sym "@keyword.conditional" { fg = cool_grey },
    sym "@keyword.coroutine" { fg = cool_grey },
    sym "@keyword.debug" { fg = mauve },
    sym "@keyword.directive" { fg = cool_grey },
    sym "@keyword.directive.define" { fg = cool_grey },
    sym "@keyword.exception" { fg = cool_grey },
    sym "@keyword.repeat" { fg = cool_grey },
    sym "@keyword.import" { fg = cool_grey },
    -- sym "@keyword.operator"          { fg = foreground },
    -- sym "@keyword.function"          { fg = c.magenta },
    -- sym "@keyword.return"            { fg = cool_grey },
    -- sym "@keyword.storage"           { fg = iceberg },

    sym "@type" { fg = iceberg },
    sym "@type.builtin" { fg = cool_grey },
    sym "@type.definition" { fg = iceberg },
    sym "@type.qualifier" { fg = cool_grey },

    sym "@string" { fg = bud_green },
    sym "@string.regexp" { fg = bud_green },
    sym "@string.documentation" { fg = bud_green },
    sym "@string.escape" { fg = mauve },

    sym "@label" { fg = cool_grey },
    sym "@markup.italic" { italic = true },
    -- sym "@markup"                    {},
    -- sym "@markup.emphasis"           { italic = true },
    -- sym "@markup.environment"        { fg = cool_grey },
    -- sym "@markup.environment.name"   { fg = iceberg },
    -- sym "@markup.heading"            { fg = mantis },
    -- sym "@markup.link"               { fg = steel_teal },
    -- sym "@markup.link.label"         { fg = steel_teal },
    -- sym "@markup.link.label.symbol"  { fg = mauve },
    -- sym "@markup.link.url"           { gui = "underline" },
    -- sym "@markup.list"               { fg = cool_grey },
    -- sym "@markup.list.checked"       { fg = mantis },
    -- sym "@markup.list.markdown"      { fg = mellow_apricot, bold = true },
    -- sym "@markup.list.unchecked"     { fg = iceberg },
    -- sym "@markup.math"               { fg = steel_teal },
    -- sym "@markup.raw"                { fg = bud_green },
    -- sym "@markup.raw.markdown_inline" { bg = total_black, fg = iceberg },
    -- sym "@markup.strikethrough"      { strikethrough = true },
    -- sym "@markup.strong"             { bold = true },
    -- sym "@markup.underline"          { underline = true },

    sym "@module" { fg = cool_grey },
    -- sym "@module.builtin"            { fg = fuzzy_wuzzy },

    sym "@namespace.builtin" { fg = cool_grey, gui = "italic" },
    -- sym "@none"                      {},
    sym "@property" { fg = foreground },
    -- sym "@tag"                       { fg = cool_grey },
    -- sym "@tag.attribute"             { fg = foreground },
    -- sym "@tag.delimiter"             { fg = foreground },
    -- sym "@tag.delimiter.tsx"         { fg = Util.blend_bg(c.blue, 0.7) },
    -- sym "@tag.tsx"                   { fg = fuzzy_wuzzy },

    sym "@variable" { fg = foreground },
    sym "@variable.builtin" { fg = foreground, gui = "bold" },
    -- sym "@variable.member"           { fg = mantis },
    -- sym "@variable.parameter"        { fg = mellow_apricot },
    -- sym "@variable.parameter.builtin" { fg = Util.blend_fg(c.yellow, 0.8) },

    -- =========================================================================
    --  Plugins
    -- =========================================================================

    -- NvimTree
    NvimTreeRootFolder { fg = cool_grey },
    NvimTreeOpenedFile { fg = mantis },
    NvimTreeOpenedFolderName { fg = iceberg },
    NvimTreeSpecialFile { fg = steel_teal },

    -- SymbolsOutline
    FocusedSymbol { fg = brandy, gui = "none" },

    -- GitSigns
    GitSignsAdd { fg = mantis },
    GitSignsChange { fg = iceberg },
    GitSignsDelete { fg = fuzzy_wuzzy },

    -- MiniStatusline
    MiniStatuslineModeNormal { fg = total_black, bg = bud_green },
    MiniStatuslineModeInsert { fg = total_black, bg = iceberg },
    MiniStatuslineModeCommand { fg = total_black, bg = fuzzy_wuzzy },
    MiniStatuslineModeOther { fg = total_black, bg = mellow_apricot },

    -- IndentBlankline
    IndentBlanklineChar { fg = cocoa_brown, gui = "nocombine" },

    -- Snacks Picker
    SnacksPickerDir { fg = iceberg },

  }
  -- stylua: ignore end
end)

vim.opt.background = "dark"
vim.g.colors_name = "covid19"
lush(theme)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
