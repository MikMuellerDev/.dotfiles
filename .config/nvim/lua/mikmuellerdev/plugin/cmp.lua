local cmp = require('cmp')
local utils = require('mikmuellerdev.utils')

-- Stop if luasnip is not (yet) installed
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
    vim.schedule(
        function() vim.notify('Did not setup nvim-cmp, because luasnip is not installed', vim.log.levels.WARN) end
    )
    return
end

local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}

utils.try_setup('cmp-npm')

cmp.setup {
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert {
        -- Tab immediately completes or jumps in snippet. Ctrl+N/Ctrl+P to select.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm { select = true }
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),

        -- Shift+Tab selects previous item or jumps backwards in snippet.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
        -- Ctrl+Space to show completions
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Ctrl+E to abort
        ['<C-E>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },

        -- Ctrl+U and Ctrl+D to scroll docs up and down respectively
        ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    },
    sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'crates' },
        { name = 'git' },
        { name = 'npm', keyword_length = 4 },
    },
    experimental = {
        ghost_text = true,
    },
    formatting = {
        -- icon, completion, source
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = kind_icons[vim_item.kind]
            -- Source
            vim_item.menu = ({
                buffer = '[Buffer]',
                path = '[Path]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                nvim_lua = '[Lua]',
                crates = '[crates.nvim]',
                git = '[Git]',
                npm = '[NPM]',
            })[entry.source.name]
            return vim_item
        end,
    },
}

-- Enable completing paths in :
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

-- Insert parentheses after function or method completion
local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if cmp_autopairs_ok then cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done()) end

utils.try_setup('cmp_git')
