(local prettier_opts {1 :prettier :lsp_format :fallback})

{1 :stevearc/conform.nvim
 :event [:BufWritePre :BufReadPre]
 :opts {:formatters_by_ft {:lua [:stylua]
                           :javascript prettier_opts
                           :typescript prettier_opts
                           :solidity [:forge_fmt]
                           :fennel [:fnlfmt]
                           :rust []
                           :toml [:taplo]}
        :format_on_save {}
        :default_format_opts {:lsp_format :prefer}}}
