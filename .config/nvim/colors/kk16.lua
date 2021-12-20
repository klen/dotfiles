local colors = {

  silver = "#c7c7c7",

  fogra39 = "#121212",

  jet = "#292929",

  steel_blue = "#427AA1",

  sonic_silver = "#787878",

  nickel = "#687373",

  bud_green = "#87AF5F",

  iceberg = "#87AFD7",

  raw_sienna = "#d75f5f",

  popstar = "#CF4C62",

  goldenrod = "#ffd787",

  ship_cove = "#8787af",

  brandy = "#d7d787",
}

local pallete = {

  -- Default Background
  base00 = colors.fogra39,

  -- Lighter Background (Used for status bars, line number and folding marks)
  base01 = colors.jet,

  -- Selection Background
  base02 = colors.steel_blue,

  -- Comments, Invisibles, Line Highlighting
  -- base03 = colors.sonic_silver,
  base03 = colors.sonic_silver,

  -- Dark Foreground (Used for status bars)
  base04 = colors.sonic_silver,

  -- Default Foreground, Caret, Delimiters, Operators
  base05 = colors.silver,

  -- Light Foreground (Not often used)
  base06 = "#000000",

  -- Light Background (Not often used)
  base07 = "#dadada",

  -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base08 = "#bcbcbc",

  -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
  -- base09 = "#d75f5f",
  -- base09 = colors.raw_sienna,
  -- base09 = colors.popstar,
  base09 = "#F18701",

  -- Classes, Markup Bold, Search Text Background
  base0A = colors.iceberg,

  -- Strings, Inherited Class, Markup Code, Diff Inserted
  base0B = colors.bud_green,

  -- Support, Regular Expressions, Escape Characters, Markup Quotes [todo]
  base0C = "#afd7ff",

  -- Functions, Methods, Attribute IDs, Headings
  base0D = colors.brandy,

  -- Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0E = colors.ship_cove,
  -- base0E = "#DB2727",

  -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?> [todo]
  base0F = "#c7c7c7",
}

require("base16-colorscheme").setup(pallete)
-- require("mini.base16").setup {
--   palette = pallete,
--   use_cterm = true,
-- }
