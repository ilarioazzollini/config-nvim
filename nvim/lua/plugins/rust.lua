return {
  {
    -- Rust analyzer (assuming it is already installed on the system)
    -- avoid using mason, so that we are sure to use the same one we can
    -- call from the command line
    require('lspconfig').rust_analyzer.setup {
      cmd = { 'rust-analyzer' }, -- uses system binary
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = true,
            check = {
              command = 'clippy',
          },
        },
      },
    }
  },
}