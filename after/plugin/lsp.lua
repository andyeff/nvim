local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    -- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    -- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
})


lsp.set_preferences({
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- default keybinds from LSP:
    -- gd - definition
    -- go - type definition
    -- gi - implementation
    -- gr - references
    -- gD - declaration
    -- gl - open floating
    -- F2 - rename
    -- F4 - code actions
    vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local rust_lsp = lsp.build_options('rust_analyzer', {})

lsp.setup()

require('rust-tools').setup({server = rust_lsp})

-- Enable the below for floating diagnostics
-- otherwise, errors will be underlined - use [d, ]d, or <leader>vd to trace
-- vim.diagnostic.config({
--   virtual_text = true,
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = false,
--   float = true,
-- })

