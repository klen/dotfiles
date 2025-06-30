#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path
from plistlib import load as load_plist
from string import Template
from typing import Dict, Iterator, Tuple

BLUE = "Blue Component"
GREEN = "Green Component"
RED = "Red Component"

GHOSTTY_TEMPLATE = """
palette = 0=$ansi0
palette = 1=$ansi1
palette = 2=$ansi2
palette = 3=$ansi3
palette = 4=$ansi4
palette = 5=$ansi5
palette = 6=$ansi6
palette = 7=$ansi7
palette = 8=$ansi8
palette = 9=$ansi9
palette = 10=$ansi10
palette = 11=$ansi11
palette = 12=$ansi12
palette = 13=$ansi13
palette = 14=$ansi14
palette = 15=$ansi15
background = $background
foreground = $foreground
cursor-color = $cursor
selection-background = $selection_bg
selection-foreground = $selection_fg
"""


def dict_from_plist_file(plistfile: Path) -> Dict:
    with open(plistfile, "rb") as pf:
        return load_plist(pf)


def rgb_to_hex(r: int, g: int, b: int) -> str:
    return f"#{r:02X}{g:02X}{b:02X}"


def component_to_int(c: str) -> int:
    return int(float(c) * 255.0)


def key_color_pairs(plistfile: Path) -> Iterator[Tuple[str, str]]:
    for key, components in dict_from_plist_file(plistfile).items():
        r = component_to_int(components[RED])
        g = component_to_int(components[GREEN])
        b = component_to_int(components[BLUE])
        yield (key, rgb_to_hex(r, g, b))


def iterm2ghostty_colors(plistfile: Path) -> Dict[str, str]:
    colors = dict(key_color_pairs(plistfile))
    return {
        "ansi0": colors.get("Ansi 0 Color", ""),
        "ansi1": colors.get("Ansi 1 Color", ""),
        "ansi2": colors.get("Ansi 2 Color", ""),
        "ansi3": colors.get("Ansi 3 Color", ""),
        "ansi4": colors.get("Ansi 4 Color", ""),
        "ansi5": colors.get("Ansi 5 Color", ""),
        "ansi6": colors.get("Ansi 6 Color", ""),
        "ansi7": colors.get("Ansi 7 Color", ""),
        "ansi8": colors.get("Ansi 8 Color", ""),
        "ansi9": colors.get("Ansi 9 Color", ""),
        "ansi10": colors.get("Ansi 10 Color", ""),
        "ansi11": colors.get("Ansi 11 Color", ""),
        "ansi12": colors.get("Ansi 12 Color", ""),
        "ansi13": colors.get("Ansi 13 Color", ""),
        "ansi14": colors.get("Ansi 14 Color", ""),
        "ansi15": colors.get("Ansi 15 Color", ""),
        "background": colors.get("Background Color", ""),
        "foreground": colors.get("Foreground Color", ""),
        "cursor": colors.get("Cursor Color", ""),
        "selection_bg": colors.get("Selection Color", ""),
        "selection_fg": colors.get("Selected Text Color", ""),
    }


def main():
    parser = argparse.ArgumentParser(
        description="Convert iTerm2 themes to Ghostty colors."
    )
    parser.add_argument(
        "-f", "--file", required=True, type=Path, help="The iTerm2 theme file path"
    )
    parser.add_argument("-o", "--output", help="Output file path (defaults to stdout)")
    args = parser.parse_args()

    ghostty_colors = iterm2ghostty_colors(args.file)

    template = Template(GHOSTTY_TEMPLATE)
    result = template.substitute(ghostty_colors)

    if args.output:
        with open(args.output, "w") as f:
            f.write(result)
    else:
        print(result)


if __name__ == "__main__":
    main()  #!/usr/bin/env python3
