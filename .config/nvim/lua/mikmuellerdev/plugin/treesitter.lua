local treesitter = require('nvim-treesitter.configs')

vim.filetype.add { extension = { ebnf = 'ebnf' } }

require('nvim-treesitter.parsers').get_parser_configs().ebnf = {
    install_info = {
        url = 'https://github.com/RubixDev/tree-sitter-ebnf.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

-- homescript language support
require('nvim-treesitter.parsers').get_parser_configs().hms = {
    install_info = {
        url = 'https://github.com/smarthome-go/tree-sitter-hms.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
    filetype = 'homescript',
}
vim.filetype.add { extension = { hms = 'homescript' } }

-- rush language support
require('nvim-treesitter.parsers').get_parser_configs().rush = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-rush.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}
vim.filetype.add { extension = { rush = 'rush' } }

vim.filetype.add { extension = { ll = 'llvm' } }

treesitter.setup {
    ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'comment',
        'cpp',
        'css',
        'diff',
        'dockerfile',
        'ebnf',
        'rush',
        'hms',
        'gdscript',
        -- 'gitattributes', -- currently experimental
        'gitignore',
        'go',
        'godot_resource',
        'gomod',
        'html',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'kotlin',
        'latex',
        'lua',
        'make',
        'markdown', -- currently experimental
        'markdown_inline', -- currently experimental
        'python',
        'rust',
        'scss',
        'svelte',
        'sxhkdrc',
        'toml',
        'typescript',
        'vim',
        'yaml',
    },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        disable = {
            'bash',
            'sxhkdrc',
        },
        additional_vim_regex_highlighting = false,
    },

    -- RRethy/nvim-treesitter-endwise
    endwise = {
        enable = true,
    },

    -- windwp/nvim-ts-autotag
    autotag = {
        enable = true,
    },

    -- andymass/vim-matchup
    matchup = {
        enable = true,
    },

    -- p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = false,
    },
}
