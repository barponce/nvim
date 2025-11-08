return {
  {"mason-org/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        check_outdated_packages_on_open = true,
      },
    })

    -- Auto-update Mason packages on startup (runs in background)
    vim.defer_fn(function()
      vim.cmd('MasonUpdate')
    end, 1000) -- Wait 1 second after startup
  end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "tailwindcss" },
      })

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
      local lspconfig = require('lspconfig')

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

      -- Lua LSP
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })

      -- TypeScript LSP
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- SourceKit LSP (Swift) - Using xcrun to find sourcekit-lsp
      lspconfig.sourcekit.setup({
        cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'swift', 'objective-c', 'objective-cpp' },
        root_dir = function(filename, bufnr)
          return lspconfig.util.root_pattern(
            'buildServer.json',
            '*.xcodeproj',
            '*.xcworkspace',
            'Package.swift',
            'compile_commands.json',
            '.git'
          )(filename)
        end,
      })

      -- Tailwind CSS LSP
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end
  }
}
