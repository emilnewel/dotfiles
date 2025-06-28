return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      -- Define the custom MSSQL LSP server
      if not configs.mssql_lsp then
        configs.mssql_lsp = {
          default_config = {
            cmd = {
              "/Users/emilnewel/code/mssql-lsp/mssql-lsp-wrapper.sh",
            },
            filetypes = { "sql" },
            root_dir = function(fname)
              return lspconfig.util.root_pattern(".git", ".sql")(fname) or vim.fn.getcwd()
            end,
            settings = {},
          },
        }
      end

      -- Ensure the server is configured in opts.servers
      if not opts.servers then
        opts.servers = {}
      end

      opts.servers.mssql_lsp = {}
    end,
  },
}
