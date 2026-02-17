[{1 :kevinhwang91/nvim-ufo
  :keys [:zR :zM :zr :zm]
  :config (fn []
            (let [ufo (require :ufo)]
              (set vim.o.foldcolumn :1)
              (set vim.o.foldlevel 99)
              (set vim.o.foldlevelstart 99)
              (set vim.o.foldenable true)
              (set vim.o.fillchars
                   "eob: ,fold: ,foldopen:,foldsep: ,foldclose:")
              (vim.keymap.set :n :zR ufo.openAllFolds {:desc "open all folds"})
              (vim.keymap.set :n :zM ufo.closeAllFolds
                              {:desc "close all folds"})
              (vim.keymap.set :n :zr ufo.openFoldsExceptKinds)
              (vim.keymap.set :n :zm ufo.closeFoldsWith
                              {:desc "close folds with higher level"})
              (ufo.setup {:provider_selector (fn [_ _ _]
                                               [:treesitter :indent])})))
  :dependencies [:kevinhwang91/promise-async]}]
