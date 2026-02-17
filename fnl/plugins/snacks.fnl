(local eevee "
⠀⠀⠀⠀⠀⠀⣀⣠⣤⡔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⣧
⠀⠀⣀⣤⣶⣿⣿⣿⣿⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠁⣼
⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⢷⣆⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠀⠀⣿
⣾⣿⣿⣟⢛⣛⣛⣛⣋⠭⠥⠿⣿⣿⣷⣤⠀⠀⠀⢀⣀⣀⣠⣀⡀⢿⡇⠀⣸⡇
⣿⣿⣿⠻⢧⠙⢯⡀⠈⠉⠙⠛⠳⢦⣝⢿⣷⢠⣾⣿⣿⣿⣿⣿⣯⣬⡥⢰⡟⠀
⢹⣯⣛⠯⢿⣾⣷⣍⡳⣤⣀⠀⠀⠀⠉⠳⣍⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡃⠀⠀
⠈⠹⣿⣿⣾⣿⣿⣿⣿⣷⣭⣛⠷⢦⣤⣤⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀⠀
⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⢋⣵⡾⣣⣤⣦⢻⣿⣿⣿⣻⠻⣿⣿⣿⡏⠖⢻⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠉⠉⣱⣿⡟⠼⣻⣿⣿⢸⣿⣿⡇⡛⠀⣿⣿⣿⣧⡠⣸⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣷⢹⣿⣿⣿⣏⢿⣿⣷⣕⣧⣿⣿⣿⢿⣿⡿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣠⢿⣿⡟⣿⣷⣭⣻⠿⢿⠿⠷⢞⣫⣵⠿⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡟⣎⢿⣧⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⠁⠻⣷⡝⣩⣿⣿⣿⣿⣿⣿⣿⠿⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⠀⠀⠀⠀⣿⣿⣿⠉⠙⢻⢟⣿⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⡀⠀⠸⣿⣿⡇⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⢿⡧⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀
")

(local dashboard_opts
       {:enabled true
        :preset {:keys [{:icon " "
                         :key :f
                         :desc "Find File"
                         :action ":lua Snacks.dashboard.pick('files')"}
                        {:icon " "
                         :key :n
                         :desc "New File"
                         :action ":ene | startinsert"}
                        {:icon " "
                         :key :g
                         :desc "Find Text"
                         :action ":lua Snacks.dashboard.pick('live_grep')"}
                        {:icon " "
                         :key :r
                         :desc "Recent Files"
                         :action ":lua Snacks.dashboard.pick('oldfiles')"}
                        {:icon " "
                         :key :c
                         :desc :Config
                         :action ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"}
                        {:icon " "
                         :key :s
                         :desc "Restore Session"
                         :action ":lua MiniSessions.select()"}
                        {:icon "󰒲 "
                         :key :L
                         :desc :Lazy
                         :action ":Lazy"
                         :enabled (not= (. package.loaded :lazy) nil)}
                        {:icon " " :key :q :desc :Quit :action ":qa"}]
                 :header eevee}
        :sections [{:section :header}
                   {:section :keys :gap 1 :padding 1 :pane 2}]})

{1 :folke/snacks.nvim
 :priority 1000
 :event :VimEnter
 :opts {:picker {}
        :image {:enabled true}
        :dashboard dashboard_opts
        :terminal {}
        :bigfile {:enabled true}
        :quickfile {:enabled true}
        :scratch {:enabled true}
        :notifier {:enabled true :style :minimal}}
 :keys [{1 :<leader>.
         2 "<cmd>lua Snacks.scratch()<cr>"
         :desc "Toggle Scratch Buffer"}
        {1 :<leader>SS
         2 "<cmd>lua Snacks.scratch.select()<cr>"
         :desc "[S]earch [H]elp"}]
 :config (fn [opts]
           (local snacks (require :snacks))
           (snacks.setup opts.opts)
           (vim.keymap.set :n :<leader>sh "<cmd>lua Snacks.picker.help()<cr>"
                           {:desc "[S]earch [H]elp"})
           (vim.keymap.set :n :<leader>sk
                           "<cmd>lua Snacks.picker.keymaps()<cr>"
                           {:desc "[S]earch [K]eymaps"})
           (vim.keymap.set :n :<leader>sf "<cmd>lua Snacks.picker.files()<cr>"
                           {:desc "[S]earch [F]iles"})
           (vim.keymap.set :n :<leader>ss
                           "<cmd>lua Snacks.picker.pickers()<cr>"
                           {:desc "[S]earch [S]elect pickers"})
           (vim.keymap.set :n :<leader>sw
                           "<cmd>lua Snacks.picker.grep_word()<cr>"
                           {:desc "[S]earch current [W]ord"})
           (vim.keymap.set :n :<leader>sg "<cmd>lua Snacks.picker.grep()<cr>"
                           {:desc "[S]earch by [G]rep"})
           (vim.keymap.set :n :<leader>sd
                           "<cmd>lua Snacks.picker.diagnostics()<cr>"
                           {:desc "[S]earch [D]iagnostics"}) ; sde ; sdw
           (vim.keymap.set :n :<leader>sr "<cmd>lua Snacks.picker.resume()<cr>"
                           {:desc "[S]earch [R]esume"})
           (vim.keymap.set :n :<leader>s. "<cmd>lua Snacks.picker.recent()<cr>"
                           {:desc "[S]earch Recent Files (\".\" for repeat)"})
           (vim.keymap.set :n :<leader>gf
                           "<cmd>lua Snacks.picker.git_files()<cr>"
                           {:desc "Search [G]it [F]iles"})
           (vim.keymap.set :n :<leader><space>
                           "<cmd>lua Snacks.picker.buffers({ filter = { cwd = true } })<cr>"
                           {:desc "[ ] Find existing buffers"})
           (vim.keymap.set :n :<leader>/ "<cmd>lua Snacks.picker.lines()<cr>"
                           {:desc "[/] Fuzzily search in current buffer"})
           (vim.keymap.set :n :<leader>s/
                           "<cmd>lua Snacks.picker.grep_buffers()<cr>"
                           {:desc "[S]earch [/] in Open Files"})
           (vim.keymap.set :n :<leader>sn
                           "<cmd>lua Snacks.picker.files( { cwd = vim.fn.stdpath(\"config\")  })<cr>"
                           {:desc "[S]earch [N]eovim files"})
           (vim.keymap.set :n :<leader>un
                           "<cmd>lua Snacks.notifier.show_history()<cr>"
                           {:desc "Show [N]otification history"}))}
