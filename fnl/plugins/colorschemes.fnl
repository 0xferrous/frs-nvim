[{1 :catppuccin/nvim :name :catppuccin :lazy true}
 {1 :rose-pine/neovim
  :lazy true
  :config (fn []
            (let [rose-pine (require :rose-pine)]
              (rose-pine.setup {:enable {:terminal false}})))}
 {1 :rebelot/kanagawa.nvim :lazy true}
 {1 :nyoom-engineering/oxocarbon.nvim :lazy true}
 {1 :nvimdev/nightsky.vim :lazy true}
 {1 :folke/tokyonight.nvim
  :lazy true
  :opts {:styles {:comments {:italic true} :functions {:italic true}}}}
 {1 :oxfist/night-owl.nvim :lazy true}
 {1 :cocopon/iceberg.vim :lazy true}
 {1 :sainnhe/gruvbox-material
  :priority 1000
  :lazy false
  :config (fn []
            (set vim.g.gruvbox_material_enable_italic true)
            (set vim.g.gruvbox_material_background :hard)
            (set vim.g.gruvbox_material_foreground :original)
            (set vim.g.gruvbox_material_inlay_hints_background :dimmed)
            (when vim.g.neovide?
              (set vim.g.gruvbox_material_transparent_background 0))
            (if (= vim.g.neovide true)
                (set vim.g.gruvbox_material_transparent_background 0)
                (set vim.g.gruvbox_material_transparent_background 1)))}]
