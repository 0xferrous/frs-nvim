[{1 :mhartington/formatter.nvim
  :enabled false
  :config (fn []
            (let [filetypes (require :formatter.filetypes)
                  config {:filetype {:typescript (. filetypes :typescript
                                                    :prettier)
                                     :typescriptreact (. filetypes
                                                         :typescriptreact
                                                         :prettier)
                                     :lua (. filetypes :lua :stylua)
                                     :nix (. filetypes :nix :nixpkgs_fmt)
                                     :json (. filetypes :json :prettier)
                                     :solidity (fn []
                                                 {:exe :forge
                                                  :args [:fmt :--raw "-"]})
                                     ; :fennel (fn [] {:exe "fnlfmt" :args ["-"]})
                                     :toml (. filetypes :toml :taplo)}}
                  formatter (require :formatter)
                  ignored ((require :plenary.collections.py_list) [:toml])]
              (formatter.setup config)
              (vim.keymap.set :n :<leader>f :<cmd>FormatWrite<CR>
                              {:desc "format and write"})
              (vim.keymap.set :n :<leader>F :<cmd>Format<CR>
                              {:desc "format without write"})
              (vim.api.nvim_create_autocmd [:BufWritePre]
                                           {:pattern ["*"]
                                            :callback (fn [ev]
                                                        (when ev.buf
                                                          (let [bufnr ev.buf
                                                                bufvars (. vim.b
                                                                           bufnr)]
                                                            (when (not (and bufvars
                                                                            (. bufvars
                                                                               :lsp_fmt_aucmd)))
                                                              (let [ft (. vim.bo
                                                                          bufnr
                                                                          :filetype)]
                                                                (when (not (ignored:contains ft))
                                                                  (vim.cmd :Format)))))))})
              nil))
  :dependencies [:nvim-lua/plenary.nvim]}]
