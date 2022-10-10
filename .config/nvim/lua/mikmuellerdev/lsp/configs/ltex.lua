return {
    settings = {
        ltex = {
            additionalRules = {
                enablePickyRules = true,
                motherTongue = 'de-De',
            },
        },
    },
    on_attach = function(_, bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }

        -- Set language to German in LaTeX files
        map('n', '<leader>ll', ':call append(line("0"), ["% LTeX: language=de-DE"])<CR>', opts)
        -- Set language to German in markdown files
        map('n', '<Leader>ml', ':call append(line("0"), ["---", "lang: de-DE", "---", ""])<CR>', opts)
    end,
}
