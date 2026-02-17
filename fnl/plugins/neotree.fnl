(let [filesystem {:window {:mappings {"\\" :close_window}}}]
  {1 :nvim-neo-tree/neo-tree.nvim
   :branch :v3.x
   :enabled true
   :dependencies [:nvim-lua/plenary.nvim
                  :nvim-tree/nvim-web-devicons
                  :MunifTanjim/nui.nvim]
   :cmd :Neotree
   :keys [{1 "\\" 2 ":Neotree reveal<CR>" :desc "NeoTree reveal" :silent true}]
   :opts {: filesystem
          :sources [:filesystem :buffers :git_status :document_symbols]}})
