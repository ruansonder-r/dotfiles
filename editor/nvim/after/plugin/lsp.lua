local name = "lsp-zero"
local ok, lsp_zero = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

-- lsp_attach is where you enable features that only work
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  -- apply format keybinding
  vim.keymap.set({'n', 'x'}, 'gq', function()
    vim.lsp.buf.format({async = false, timeout_ms = 10000})
  end, opts)
end

local cmp_lsp = 'cmp_nvim_lsp'
local cmp_lsp_ok, cmp_lsp_pckg = pcall(require, cmp_lsp)
if not cmp_lsp_ok then
  packer_missing(cmp_lsp)
  return
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = cmp_lsp_pckg.default_capabilities(),
})

local name2 = "lspconfig"
local ok2, lspconfig = pcall(require, name2)
if not ok2 then
  packer_missing(name2)
  return
end

-- LSPs on system
lspconfig.ruby_lsp.setup{
--  settings = {
--    rubocop = {
--      useBundler = true,  -- Use Bundler to run RuboCop
--      autoCorrect = false,  -- Set to true if you want auto-corrections
--    },
--  }
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },  -- Add globals like 'vim' if using Neovim
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),  -- Enable runtime files
        checkThirdParty = false,  -- Set to true if you want to check third-party libraries
      },
      telemetry = {
        enable = false,  -- Disable telemetry
      },
    },
  },
}

lspconfig.nil_ls.setup{}

-- Auto completion
local name3 = "cmp"
local ok3, cmp = pcall(require, name3)
if not ok3 then
  packer_missing(name3)
  return
end

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})

-- require'lspconfig'.lua_lsp.setup{}
-- require'lspconfig'.rubocop.setup{}
-- lsp_zero.nvim_workspace() -- (Optional) Configure lua language server for neovim

-- lsp_zero.format_on_save({
--   format_opts = { async = true,
--   timeout_ms = 10000,
-- },
-- servers = {
--   ['lua_ls'] = { 'lua' },
--   ['rubocop'] = { 'ruby' },
-- }
-- })
-- 
-- lsp_zero.configure("rubocop", {
--   cmd = { "bundle", "exec", "rubocop", "." , "--lsp" }
-- })
