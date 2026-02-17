[{1 :llllvvuu/neotest-foundry :lazy true}
 {1 :nvim-neotest/neotest
  :dependencies [:nvim-neotest/nvim-nio
                 :nvim-lua/plenary.nvim
                 :antoinemadec/FixCursorHold.nvim
                 :nvim-treesitter/nvim-treesitter
                 :llllvvuu/neotest-foundry]
  :lazy true
  :config (fn []
            ((. (require :neotest) :setup)
             {:adapters [(require :neotest-foundry)]}))}]
