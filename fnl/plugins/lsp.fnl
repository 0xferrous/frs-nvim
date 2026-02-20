(local servers {:gopls {}
                ; :pyright {}
                :ty {}
                :ts_ls {}
                :lua_ls {:Lua {:workspace {:checkThirdParty false}
                               :telemetry {:enable false}}}
                :ccls {:init_options {:compilationDatabaseDirectory :build}}
                :zk {}
                :nushell {}
                :marksman {}
                ; TODO: configure Solidity LSP
                :zls {}})

(fn configure_lsp_servers [servers]
  (each [lsp_name config (pairs servers)]
    (vim.lsp.config lsp_name config)
    (vim.lsp.enable lsp_name)))

(fn on_attach [client buf]
  (let [nmap (fn [keys func desc]
               (vim.keymap.set :n keys func
                               {:buffer buf :desc (.. "LSP: " desc)}))]
    (when (and client
               (client:supports_method vim.lsp.protocol.Methods.textDocument_inlayHint))
      (vim.lsp.inlay_hint.enable)
      (nmap :<leader>th
            (fn []
              (vim.lsp.inlay_hint.enable (not (vim.lsp.inlay_hint.is_enabled {:bufnr buf}))))
            "Toggle [T]ype Hints")) ; TODO : change default diagnostic symbols
    (nmap :gd vim.lsp.buf.definition "[G]oto [D]efinition")
    (nmap :gD vim.lsp.buf.declaration "[G]oto [D]eclaration")
    (nmap :gI (. (require :telescope.builtin) :lsp_implementations)
          "[G]oto [I]mplementation")
    (nmap :<leader>D vim.lsp.buf.type_definition "Type [D]efinition")
    (nmap :<leader>ds (. (require :telescope.builtin) :lsp_document_symbols)
          "[D]ocument [S]ymbols")
    (nmap :<leader>ws (. (require :telescope.builtin)
                         :lsp_dynamic_workspace_symbols)
          "[W]orkspace [S]ymbols")
    (nmap :<c-k> vim.lsp.buf.signature_help "Signature Documentation")
    (nmap :<leader>wa vim.lsp.buf.add_workspace_folder
          "Add [W]orkspace [A]dd Folder")
    (nmap :<leader>wr vim.lsp.buf.remove_workspace_folder
          "Remove [W]orkspace [R]emove Folder")
    (nmap :<leader>wl
          (fn []
            (print vim.inspect vim.lsp.buf.list_workspace_folders))
          "[W]orkspace [L]ist Folders")
    (vim.api.nvim_buf_create_user_command buf :FormatLsp
                                          (fn [] (vim.lsp.buf.format))
                                          {:desc "Format current buffer with LSP"})))

(fn setup_lsp []
  (let [capabilities ((. vim.lsp.protocol :make_client_capabilities))
        blink (require :blink.cmp)]
    (var capabilities capabilities)
    (set capabilities (blink.get_lsp_capabilities capabilities))
    (set (. capabilities :textDocument :foldingRange)
         {:dynamicRegistration false :lineFoldingOnly true})
    (vim.lsp.config "*" {: capabilities})
    (configure_lsp_servers servers)
    (set (. vim.g :rustaceanvim) {:tools {}
                                  :server {: on_attach
                                           :default_settings {:rust-analyzer {}}}
                                  :dap {}})
    ((. (require :crates) :setup) {:lsp {:enabled true
                                         : on_attach
                                         :actions true
                                         :completion true
                                         :hover true}})
    (vim.api.nvim_create_autocmd :LspAttach
                                 {:callback (fn [ev]
                                              (let [client (vim.lsp.get_client_by_id ev.data.client_id)]
                                                (on_attach client ev.buf)))})))

[{1 :saecki/crates.nvim
  :lazy true
  :on_require :crates}
 {1 :neovim/nvim-lspconfig
  :event [:BufReadPre :BufNewFile]
  :dependencies [{1 :j-hui/fidget.nvim
                  :opts {:notification {:window {:winblend 0}}}}
                 {1 :folke/neodev.nvim
                  ; NOTE: .nvim marker hack: force-enable neodev plugin library in this repo
                  :opts {:override (fn [root_dir library]
                                     (when (= (string.find root_dir :.nvim 1 true)
                                              1)
                                       (set (. library :enabled) true)
                                       (set (. library :plugins) true)))}}
                 :mrcjkb/rustaceanvim
                 :saghen/blink.cmp
                 :saecki/crates.nvim]
  :config (fn []
            (setup_lsp))}]
