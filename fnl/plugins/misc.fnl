[{1 :0xferrous/ansi.nvim
  :ft :ansi
  :opts {:auto_enable true :filetypes [:ansi] :theme :gruvbox_dark}}
 {1 :0xferrous/eth.nvim
  :lazy true
  :opts {}}
 {1 :zk-org/zk-nvim
  :name :zk
  :lazy true
  :opts {:picker :select :lsp {:auto_attach {:enabled false}}}}
 {1 :elkowar/yuck.vim :ft :yuck}
 {1 :iden3/vim-circom-syntax :ft :circom}
 {1 :morhetz/gruvbox
  :lazy true
  :config (fn []
            (set vim.g.gruvbox_italic 1)
            (set vim.g.gruvbox_improved_strings 1)
            (set vim.g.gruvbox_undercurl 1))}
 {1 :rafcamlet/nvim-luapad
  :cmd [:Luapad :LuaRun]
  :config (fn []
            (vim.keymap.set :n :<leader>lr :LuaRun<CR> {:desc "[L]ua [R]un"}))}
 {1 :rmagatti/goto-preview
  :dependencies [:rmagatti/logger.nvim]
  :event :BufEnter
  :config true}
 {1 :nvim-orgmode/orgmode
  :event :VeryLazy
  :ft [:org]
  :config (fn []
            (let [data-dir (vim.fn.stdpath :data)]
              ((. (require :orgmode) :setup)
               {:org_agenda_files (.. data-dir "/org/**/*")
                :org_default_notes_file (.. data-dir "/org/refile.org")})))}
 {1 :RRethy/vim-illuminate
  :event :VeryLazy
  :config (fn []
            ((. (require :illuminate) :configure)
             {:min_count_to_highlight 2
              :providers [:lsp :regex]}))}
 {1 :godlygeek/tabular :cmd :Tabularize}
 {1 :dhruvasagar/vim-table-mode :ft [:markdown :org :txt]}
 {1 :mikesmithgh/kitty-scrollback.nvim
  :lazy true
  :cmd [:KittyScrollbackGenerateKittens
        :KittyScrollbackCheckHealth
        :KittyScrollbackGenerateCommandLineEditing]
  :event ["User KittyScrollbackLaunch"]
  :config true
  :opts {1 {:restore_options true}}}
 {1 :glacambre/firenvim :lazy true :build ":call firenvim#install(0)"}]
