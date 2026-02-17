(local get_toggleterm_id
       (fn []
         (let [winid (vim.api.nvim_get_current_win)
               bufnr (vim.api.nvim_get_current_buf)
               bufvars (. vim.b bufnr)
               tid (or (. bufvars :toggle_number) "!")]
           (.. "w: " winid " b: " bufnr " t: " tid))))

{1 :nvim-lualine/lualine.nvim
 :event :VeryLazy
 :opts {:options {:icons_enabled false
                  :theme :gruvbox
                  :component_separators "|"
                  :section_separators ""
                  :always_show_tabline true}
        :sections {:lualine_a [:mode]
                   :lualine_b [:branch :diff :diagnostics]
                   :lualine_c [[:filename {:path 1}]]
                   :lualine_x [:encoding
                               :fileformat
                               :filetype
                               (fn []
                                 ((. vim.fn :bufnr)))
                               :overseer]
                   :lualine_y [:progress]
                   :lualine_z [:location]}
        :inactive_sections {:lualine_a [:mode]
                            :lualine_b []
                            :lualine_c [:filename]
                            :lualine_x [:location]
                            :lualine_y []}}}
