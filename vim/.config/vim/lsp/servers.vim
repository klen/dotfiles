" LSP servers (yegappan/lsp). Uses Mason-installed servers when present.

let s:mason = expand('~/.local/share/nvim/mason/bin')

function! s:exe(name) abort
    let path = s:mason . '/' . a:name
    return executable(path) ? path : a:name
endfunction

let g:lsp_servers = [
    \ #{
    \   name: 'vtsls',
    \   filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
    \   path: s:exe('vtsls'),
    \   args: ['--stdio'],
    \ },
    \ #{
    \   name: 'biome',
    \   filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc', 'css', 'graphql'],
    \   path: s:exe('biome'),
    \   args: ['lsp-proxy'],
    \ },
    \ #{
    \   name: 'pyrefly',
    \   filetype: 'python',
    \   path: s:exe('pyrefly'),
    \   args: ['lsp'],
    \ },
    \ #{
    \   name: 'ruff',
    \   filetype: 'python',
    \   path: s:exe('ruff'),
    \   args: ['server'],
    \ },
    \ #{
    \   name: 'lua_ls',
    \   filetype: 'lua',
    \   path: s:exe('lua-language-server'),
    \   args: [],
    \   workspaceConfig: #{
    \     Lua: #{
    \       runtime: #{version: 'LuaJIT'},
    \       workspace: #{checkThirdParty: v:false, library: [expand('$VIMRUNTIME')]},
    \     },
    \   },
    \ },
    \ #{
    \   name: 'marksman',
    \   filetype: 'markdown',
    \   path: s:exe('marksman'),
    \   args: ['server'],
    \ },
    \ #{
    \   name: 'taplo',
    \   filetype: 'toml',
    \   path: s:exe('taplo'),
    \   args: ['lsp', 'stdio'],
    \ },
    \ #{
    \   name: 'rust_analyzer',
    \   filetype: 'rust',
    \   path: s:exe('rust-analyzer'),
    \   args: [],
    \   syncInit: v:true,
    \ },
    \ #{
    \   name: 'zls',
    \   filetype: 'zig',
    \   path: s:exe('zls'),
    \   args: [],
    \   workspaceConfig: #{
    \     zls: #{
    \       warn_style: v:true,
    \       enable_inlay_hints: v:true,
    \       inlay_hints_show_variable_type_hints: v:true,
    \     },
    \   },
    \ }
    \ ]
