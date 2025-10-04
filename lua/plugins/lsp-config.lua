return {
  {"mason-org/mason.nvim",
  config = function()
    require("mason").setup()
  end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "tailwindcss" }
      })

      require("mason").setup()
      local registry = require("mason-registry")

      -- Auto-install swiftlint
      local p = registry.get_package("swiftlint")
      if not p:is_installed() then
        p:install()
      end
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          spacing = 4,
        },
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
        },
      })

      -- Define diagnostic signs
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          }
        }
      })

      -- Add background highlighting for diagnostics
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', { bg = '#3f2d3d', fg = '#f38ba8' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextWarn', { bg = '#3d3830', fg = '#f9e2af' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { bg = '#2d3640', fg = '#89dceb' })
      vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextInfo', { bg = '#2d3640', fg = '#89b4fa' })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gdf', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gds', function() vim.cmd('split') vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', 'gdc', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gim', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end

      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }

      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      vim.lsp.config.sourcekit = {
        cmd = { 'sourcekit-lsp' },
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
      }

      vim.lsp.config.tailwindcss = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      vim.lsp.enable({ 'lua_ls', 'ts_ls', 'sourcekit', 'tailwindcss' })
    end
  }
}
