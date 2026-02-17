(fn treesitter_configure_localparsers []
  (let [parsers (require :nvim-treesitter.parsers)]
    (when (= (type parsers) :table)
      (set (. parsers :noir)
           {:install_info {:url "https://github.com/hhamud/tree-sitter-noir"
                           :files [:src/parser.c :src/scanner.c]
                           :branch :main}
            :filetype :noir}))))

[{1 :nvim-treesitter/nvim-treesitter
  :dependencies [:nvim-treesitter/nvim-treesitter-textobjects]
  :build :TSUpdate
  :event [:BufReadPost :BufNewFile]
  :config (fn []
            (vim.defer_fn (fn []
                            ((. (require :nvim-treesitter) :setup) {:highlight {:enable true
                                                                                  :disable [:typescript
                                                                                            :tsx]}
                                                                      :indent {:enable true}
                                                                      :incremental_selection {:enable true
                                                                                              :keymaps {:init_selection :<c-space>
                                                                                                        :node_incremental :<c-space>
                                                                                                        :scope_incremental :<c-s>
                                                                                                        :node_decremental :<m-space>}}
                                                                      :textobjects {:select {:enable true
                                                                                             :lookahead true
                                                                                             :keymaps {:aa "@parameter.outer"
                                                                                                       :ia "@parameter.inner"
                                                                                                       :af "@function.outer"
                                                                                                       :if "@function.inner"
                                                                                                       :ac "@class.outer"
                                                                                                       :ic "@class.inner"}}
                                                                                    :move {:enable true
                                                                                           :set_jumps true
                                                                                           :goto_next_start {"]m" "@function.outer"
                                                                                                             "]]" "@class.outer"}
                                                                                           :goto_next_end {"]M" "@function.outer"
                                                                                                           "][" "@class.outer"}
                                                                                           :goto_previous_start {"[m" "@function.outer"
                                                                                                                 "[[" "@class.outer"}
                                                                                           :goto_previous_end {"[M" "@function.outer"
                                                                                                               "[]" "@class.outer"}}
                                                                                    :swap {:enable false
                                                                                           :swap_next {:<leader>a "@parameter.inner"}
                                                                                           :swap_previous {:<leader>A "@parameter.inner"}}}})
                            (treesitter_configure_localparsers))
              0))}]
