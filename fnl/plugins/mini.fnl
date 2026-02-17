[{1 :nvim-mini/mini.nvim
  :event :VeryLazy
  :config (fn []
            ((. (require :mini.ai) :setup) {:n_lines 500})
            ((. (require :mini.surround) :setup) {:mappings {:add :ys
                                                             :delete :ds
                                                             :change :cs}})
            (let [MiniSessions (require :mini.sessions)
                  input (. (require :snacks) :input :input)]
              (MiniSessions.setup)
              (vim.keymap.set :n :<leader>Sc
                              (fn []
                                (input "Session name: "
                                       (fn [session_name]
                                         (MiniSessions.write session_name))))
                              {:desc "Write a new session"})
              (vim.keymap.set :n :<leader>Ss MiniSessions.select
                              {:desc "Select a session"}))
            (let [indentscope (require :mini.indentscope)]
              (indentscope.setup {:draw {:animation ((. indentscope
                                                        :gen_animation :none))}})))}]
