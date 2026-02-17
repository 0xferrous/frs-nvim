[{1 :vhyrro/luarocks.nvim :priority 1000 :config true}
 {1 :nvim-neorg/neorg
  :dependencies [:luarocks.nvim]
  :version "*"
  :ft :norg
  :config (fn []
            (vim.api.nvim_create_autocmd :Filetype
                                         {:pattern :norg
                                          :callback (fn []
                                                      (let [nmap (fn [lhs rhs]
                                                                   (vim.keymap.set :n
                                                                                   lhs
                                                                                   rhs
                                                                                   {:buffer true}))]
                                                        (nmap :<LocalLeader>td
                                                              "<Plug>(neorg.qol.todo-items.todo.task-done)")
                                                        (nmap :<LocalLeader>tu
                                                              "<Plug>(neorg.qol.todo-items.todo.task-undone)")
                                                        (nmap :<LocalLeader>tp
                                                              "<Plug>(neorg.qol.todo-items.todo.task-pending)")
                                                        (nmap :<LocalLeader>th
                                                              "<Plug>(neorg.qol.todo-items.todo.task-on_hold)")
                                                        (nmap :<LocalLeader>tc
                                                              "<Plug>(neorg.qol.todo-items.todo.task-cancelled)")
                                                        (nmap :<LocalLeader>tr
                                                              "<Plug>(neorg.qol.todo-items.todo.task-recurring)")
                                                        (nmap :<LocalLeader>ti
                                                              "<Plug>(neorg.qol.todo-items.todo.task-important)")
                                                        (nmap :<C-Space>
                                                              "<Plug>(neorg.qol.todo-items.todo.task-cycle)")
                                                        (nmap :<S-Right>
                                                              "<Plug>(neorg.qol.todo-items.todo.task-cycle)")))})
            (let [load {}]
              (set (. load :core.defaults) {})
              (set (. load :core.concealer) {})
              (let [dirman {:config {:workspaces {:work "~/neorg/work"
                                                  :personal "~/neorg/personal"}
                                     :default_workspace :personal}}]
                (set (. load :core.dirman) dirman))
              (set (. load :core.ui.calendar) {})
              (set (. load :core.summary) {})
              (set (. load :core.tangle) {})
              (set (. load :core.looking-glass) {})
              (set (. load :core.export) {})
              (set (. load :core.export.markdown) {})
              ((. (require :neorg) :setup) {: load}))
            (set (. vim.wo :foldlevel) 99))}]
