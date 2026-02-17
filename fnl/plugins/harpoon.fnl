[{1 :ThePrimeagen/harpoon
  :branch :harpoon2
  :dependencies [:nvim-lua/plenary.nvim]
  :keys [:<C-h> :<C-j> :<C-k> :<C-l> :<C-e> :ha :hr :hn :hp]
  :config (fn []
            (let [harpoon (require :harpoon)
                  conf (. (require :telescope.config) :values)
                  pickers (require :telescope.pickers)
                  finders (require :telescope.finders)
                  harpoon_extensions (require :harpoon.extensions)
                  toggle_telescope (fn [harpoon_files]
                                     (let [file_paths []]
                                       (each [_ item (ipairs (. harpoon_files
                                                                :items))]
                                         (table.insert file_paths
                                                       (. item :value)))
                                       (let [picker (pickers.new {}
                                                                 {:prompt_title :Harpoon
                                                                  :finder (finders.new_table {:results file_paths})
                                                                  :previewer (conf.file_previewer {})
                                                                  :sorter (conf.generic_sorter {})})]
                                         (picker:find))))]
              (harpoon:setup)
              (vim.keymap.set :n :<C-h>
                              (fn []
                                (let [list (harpoon:list)]
                                  (list:select 1)))
                              {:desc "select file 1 from harpoon"})
              (vim.keymap.set :n :<C-j>
                              (fn []
                                (let [list (harpoon:list)]
                                  (list:select 2)))
                              {:desc "select file 2 from harpoon"})
              (vim.keymap.set :n :<C-k>
                              (fn []
                                (let [list (harpoon:list)]
                                  (list:select 3)))
                              {:desc "select file 3 from harpoon"})
              (vim.keymap.set :n :<C-l>
                              (fn []
                                (let [list (harpoon:list)]
                                  (list:select 4)))
                              {:desc "select file 4 from harpoon"})
              (vim.keymap.set :n :ha
                              (fn []
                                ((harpoon:list) :add))
                              {:desc "add buffer to harpoon" :noremap true})
              (vim.keymap.set :n :hr (fn [] ((harpoon:list) :remove))
                              {:desc "remove buffer from harpoon"})
              (vim.keymap.set :n :hn (fn [] ((harpoon:list) :next))
                              {:desc "open next harpoon file"})
              (vim.keymap.set :n :hp (fn [] ((harpoon:list) :prev))
                              {:desc "open prev harpoon file"})
              (vim.keymap.set :n :<C-e>
                              (fn []
                                (toggle_telescope (harpoon:list)))
                              {:desc "Open harpoon window"})
              (harpoon:extend ((. harpoon_extensions :builtins
                                  :highlight_current_file)))))}]
