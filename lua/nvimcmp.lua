-- Setup nvim-cmp.
local cmp = require'cmp'

local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
    --     { name = 'path' }
    --   }, {
      --     { name = 'cmdline' }
      --   })
      -- })
      
      
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- Disable short command :! autocomplete
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'buffer' }
  }, {
    { name = 'path' }
  }, {
    { name = 'cmdline', keyword_pattern=[=[[^[:blank:]\!]*]=], keyword_length=3}
  })
})

-- Setup lspconfig.
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("[d", function() vim.diagnostic.goto_next() end)
			nnoremap("]d", function() vim.diagnostic.goto_prev() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require('lspconfig').pyright.setup {
--   capabilities = capabilities
-- }
require('lspconfig').pyright.setup(config({}))

-- These taken from theprimeagen as I don't know any better
require("lspconfig").gopls.setup(config({
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}))

require("lspconfig").rust_analyzer.setup(config({
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  --[[
    settings = {
        rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
        },
    }
    --]]
}))


-- require('lspconfig').yamlls.setup(config({
--   settings = {
--     yaml = {
--       schemas = {
--         ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "/home/andyf/github/smg-cloudformation/*.y?ml",
--         ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json"] = "/home/andyf/github/**/*-template.y?ml"
--       },
--       customTags = {
--         "!And",
--         "!And sequence",
--         "!If",
--         "!If sequence",
--         "!Not",
--         "!Not sequence",
--         "!Equals",
--         "!Equals sequence",
--         "!Or",
--         "!Or sequence",
--         "!FindInMap",
--         "!FindInMap sequence",
--         "!Base64",
--         "!Join",
--         "!Join sequence",
--         "!Cidr",
--         "!Ref",
--         "!Sub",
--         "!Sub sequence",
--         "!GetAtt",
--         "!GetAZs",
--         "!ImportValue",
--         "!ImportValue sequence",
--         "!Select",
--         "!Select sequence",
--         "!Split",
--         "!Split sequence"
--       },
--     },
--   },
-- }))


require('lspconfig').yamlls.setup(config({
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = "/home/andyf/github/smg-cloudformation/*.y?ml"
      },
      customTags = {
        "!And",
        "!And sequence",
        "!If",
        "!If sequence",
        "!Not",
        "!Not sequence",
        "!Equals",
        "!Equals sequence",
        "!Or",
        "!Or sequence",
        "!FindInMap",
        "!FindInMap sequence",
        "!Base64",
        "!Join",
        "!Join sequence",
        "!Cidr",
        "!Ref",
        "!Sub",
        "!Sub sequence",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!ImportValue sequence",
        "!Select",
        "!Select sequence",
        "!Split",
        "!Split sequence"
      },
    },
  },
}))
