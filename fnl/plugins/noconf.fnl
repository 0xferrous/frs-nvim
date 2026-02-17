[; Comment plugin - load on keys
 {1 :numToStr/Comment.nvim :event :VeryLazy :opts {}}
 ; GitHub integration - load on command
 {1 :pwntester/octo.nvim :cmd :Octo :opts {}}
 ; Motion plugin - load on keys
 {1 :smoka7/hop.nvim :keys [:s :S] :opts {}}
 ; Better % matching - load with buffers
 {1 :andymass/vim-matchup :event [:BufReadPost :BufNewFile] :opts {}}
 ; TODO highlighting
 {1 :folke/todo-comments.nvim
  :event [:BufReadPost :BufNewFile]
  :dependencies [:nvim-lua/plenary.nvim]
  :opts {}}
 ; Auto pairs - load on insert
 {1 :windwp/nvim-autopairs :event :InsertEnter :opts {}}
 ; Quickfix improvements - load on quickfix
 {1 :yorickpeterse/nvim-pqf :event :VeryLazy :opts {}}
 ; Floating help
 {1 :Tyler-Barham/floating-help.nvim :cmd :FloatingHelp :opts {}}
 ; Winbar breadcrumbs
 {1 :Bekaboo/dropbar.nvim
  :event [:BufReadPost :BufNewFile]
  :dependencies [:nvim-telescope/telescope-fzf-native.nvim]
  :opts {}}
 ; Git link generation
 {1 :ruifm/gitlinker.nvim
  :keys [{1 :<leader>gy :mode [:n :v]}]
  :dependencies [:nvim-lua/plenary.nvim]
  :opts {}}
 ; File explorer
 {1 :stevearc/oil.nvim
  :cmd :Oil
  :keys [{1 "-"}]
  :dependencies [:echasnovski/mini.icons]
  :opts {}}
 ; Markdown rendering
 {1 :MeanderingProgrammer/render-markdown.nvim
  :ft [:markdown :Avante :codecompanion]
  :opts {:filetypes [:markdown :Avante :codecompanion]}}
 ; Buffer management
 {1 :stevearc/stickybuf.nvim :event :VeryLazy :opts {}}
 ; Paredit for lisp
 {1 :julienvincent/nvim-paredit :ft [:clojure :fennel :lisp :scheme] :opts {}}
 ; Git commands
 {1 :tpope/vim-fugitive
  :cmd [:Git :G :Gvdiffsplit :Gread :Gwrite :Ggrep :GMove :GDelete :GBrowse]}
 ; Detect indent
 {1 :tpope/vim-sleuth :event [:BufReadPost :BufNewFile]}
 ; Vim game
 {1 :ThePrimeagen/vim-be-good :cmd :VimBeGood}
 ; Icons (needed by other plugins)
 {1 :nvim-tree/nvim-web-devicons :lazy true}
 ; Symbols outline
 {1 :simrat39/symbols-outline.nvim :cmd :SymbolsOutline}
 ; Per project notes
 {1 :JellyApple102/flote.nvim :cmd :Flote}
 ; Rainbow delimiters
 {1 :HiPhish/rainbow-delimiters.nvim :event [:BufReadPost :BufNewFile]}
 ; Startuptime profiling
 {1 :dstein64/vim-startuptime :cmd :StartupTime}
 ; ASCII diagrams
 {1 :jbyuki/venn.nvim :cmd :VBox}
 ; Activity tracking
 {1 :ActivityWatch/aw-watcher-vim :event :VeryLazy}
 ; Unix commands
 {1 :tpope/vim-eunuch
  :cmd [:Remove :Delete :Move :Rename :Chmod :Mkdir :SudoWrite :SudoEdit]}
 ; TypeScript syntax
 {1 :HerringtonDarkholme/yats.vim :ft [:typescript :typescriptreact]}
 ; Bracket mappings
 {1 :tpope/vim-unimpaired :keys ["[" "]"]}
 ; Conflict markers
 {1 :rhysd/conflict-marker.vim :event :VeryLazy}]
