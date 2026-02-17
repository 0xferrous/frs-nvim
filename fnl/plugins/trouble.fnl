{1 :folke/trouble.nvim
 :opts {}
 :cmd :Trouble
 :keys [{1 :<leader>xx 2 "<cmd>Trouble diagnostics toggle<cr>" :desc ""}
        {1 :<leader>xxe
         2 "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>"
         :desc "Error Diagnostics (Trouble)"}
        {1 :<leader>xxw
         2 "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>"
         :desc "Warning Diagnostics (Trouble)"}
        {1 :<leader>xX
         2 "<cmd>Trouble diagnostics toggle filter.buf=0<cr>"
         :desc "Buffer Diagnostics (Trouble)"}
        {1 :<leader>cs
         2 "<cmd>Trouble symbols toggle focus=false<cr>"
         :desc "Symbols (Trouble)"}
        {1 :<leader>cl
         2 "<cmd>Trouble lsp toggle focus=false win.position=right<cr>"
         :desc "LSP Definitions / references / ... (Trouble)"}
        {1 :<leader>xL
         2 "<cmd>Trouble loclist toggle<cr>"
         :desc "Location List (Trouble)"}
        {1 :<leader>xQ
         2 "<cmd>Trouble qflist toggle<cr>"
         :desc "Quickfix List (Trouble)"}]}
