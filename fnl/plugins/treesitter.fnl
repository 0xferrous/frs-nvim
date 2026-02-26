(fn treesitter_configure_localparsers []
  (let [parsers (require :nvim-treesitter.parsers)]
    (when (= (type parsers) :table)
      (set (. parsers :noir)
           {:install_info {:url "https://github.com/hhamud/tree-sitter-noir"
                           :files [:src/parser.c :src/scanner.c]
                           :branch :main}
            :filetype :noir}))))

(fn treesitter_start_for_buf [buf]
  (let [ft (or (. (. vim.bo buf) :filetype) "")]
    (when (and (not= ft "")
               (not= ft :typescript)
               (not= ft :tsx))
      (pcall vim.treesitter.start buf))))

[{1 :nvim-treesitter/nvim-treesitter
  :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
  :build :TSUpdate
  :lazy false
  :config (fn []
            ;; New nvim-treesitter on Neovim 0.11+ is mostly parser/install metadata.
            ;; Start highlighting via built-in vim.treesitter.
            ((. (require :nvim-treesitter) :setup) {})
            (treesitter_configure_localparsers)

            (let [group (vim.api.nvim_create_augroup :treesitter-start {:clear true})]
              (vim.api.nvim_create_autocmd :FileType
                                           {:group group
                                            :callback (fn [args]
                                                        (treesitter_start_for_buf args.buf))}))

            ;; Attach for the current buffer too.
            (treesitter_start_for_buf 0))}]