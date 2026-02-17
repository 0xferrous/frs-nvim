# Lazy trigger archive (pre-migration)

This file preserves the current lazy-loading intent from `nvim/fnl/plugins/*.fnl` before removing `lazy.nvim`.

## Notes

- Source of truth: Fennel plugin specs in `nvim/fnl/plugins/` (excluding `graveyard/` and `*.todo`).
- `avante.fnl` is currently empty.
- Some plugins appear in more than one spec file (e.g. `zk-org/zk-nvim`).
- `hotpot.nvim` is currently configured as always-loaded in lazy (`lazy = false`, high priority).

---

## Trigger map

### `aw-watcher.fnl`
- `lowitea/aw-watcher.nvim`
  - Trigger: no explicit lazy trigger (effectively startup/default)

### `cmp.fnl`
- `saghen/blink.cmp`
  - Trigger: `event = InsertEnter`
  - Deps: `rafamadriz/friendly-snippets`

### `codecompanion.fnl`
- `olimorris/codecompanion.nvim`
  - Trigger: keymaps (`<leader>cca`, `<LocalLeader>a`, `ga`)
  - Deps: `plenary`, `treesitter`, `fidget`, `mini.diff`, `telescope`
- `ravitemer/mcphub.nvim`
  - Trigger: `cmd = MCPHub`

### `colorschemes.fnl`
- `catppuccin/nvim` → `lazy = true`
- `rose-pine/neovim` → `lazy = true`
- `rebelot/kanagawa.nvim` → `lazy = true`
- `nyoom-engineering/oxocarbon.nvim` → `lazy = true`
- `nvimdev/nightsky.vim` → `lazy = true`
- `folke/tokyonight.nvim` → `lazy = true`
- `oxfist/night-owl.nvim` → `lazy = true`
- `cocopon/iceberg.vim` → `lazy = true`
- `sainnhe/gruvbox-material`
  - Trigger: `lazy = false`, `priority = 1000` (startup colorscheme)

### `conform.fnl`
- `stevearc/conform.nvim`
  - Trigger: `event = [BufWritePre, BufReadPre]`

### `feed.fnl`
- `neo451/feed.nvim`
  - Trigger: `cmd = Feed`
  - Deps: `folke/snacks.nvim`

### `gitsigns.fnl`
- `lewis6991/gitsigns.nvim`
  - Trigger: `event = [BufReadPre, BufNewFile]`

### `harpoon.fnl`
- `ThePrimeagen/harpoon` (branch `harpoon2`)
  - Trigger: keys (`<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`, `<C-e>`, `ha`, `hr`, `hn`, `hp`)
  - Deps: `plenary`

### `hotpot.fnl`
- `rktjmp/hotpot.nvim`
  - Trigger: `lazy = false`, `priority = 10000`, `config = false`

### `lsp.fnl`
- `neovim/nvim-lspconfig`
  - Trigger: `event = [BufReadPre, BufNewFile]`
  - Deps: `j-hui/fidget.nvim`, `folke/neodev.nvim`, `mrcjkb/rustaceanvim`, `saghen/blink.cmp`, `saecki/crates.nvim`

### `lualine.fnl`
- `nvim-lualine/lualine.nvim`
  - Trigger: `event = VeryLazy`

### `mini.fnl`
- `nvim-mini/mini.nvim`
  - Trigger: `event = VeryLazy`

### `misc.fnl`
- `0xferrous/ansi.nvim` → `ft = ansi`
- `0xferrous/eth.nvim` → `lazy = true`
- `zk-org/zk-nvim` (named `zk`) → `lazy = true`
- `elkowar/yuck.vim` → `ft = yuck`
- `iden3/vim-circom-syntax` → `ft = circom`
- `morhetz/gruvbox` → `lazy = true`
- `rafcamlet/nvim-luapad` → `cmd = [Luapad, LuaRun]`
- `rmagatti/goto-preview` → `event = BufEnter` (dep `rmagatti/logger.nvim`)
- `nvim-orgmode/orgmode` → `event = VeryLazy`, `ft = [org]`
- `RRethy/vim-illuminate` → `event = VeryLazy`
- `godlygeek/tabular` → `cmd = Tabularize`
- `dhruvasagar/vim-table-mode` → `ft = [markdown, org, txt]`
- `mikesmithgh/kitty-scrollback.nvim`
  - Triggers: `lazy = true`, `cmd = [KittyScrollbackGenerateKittens, KittyScrollbackCheckHealth, KittyScrollbackGenerateCommandLineEditing]`, `event = ["User KittyScrollbackLaunch"]`
- `glacambre/firenvim` → `lazy = true`, `build = :call firenvim#install(0)`

### `neorg.fnl`
- `vhyrro/luarocks.nvim`
  - Trigger: `priority = 1000`, `config = true`
- `nvim-neorg/neorg`
  - Trigger: `ft = norg`
  - Deps: `luarocks.nvim`

### `neotest.fnl`
- `llllvvuu/neotest-foundry` → `lazy = true`
- `nvim-neotest/neotest`
  - Trigger: `lazy = true`
  - Deps: `nvim-nio`, `plenary`, `FixCursorHold.nvim`, `treesitter`, `neotest-foundry`

### `neotree.fnl`
- `nvim-neo-tree/neo-tree.nvim`
  - Trigger: `cmd = Neotree`, key `\`
  - Deps: `plenary`, `nvim-web-devicons`, `nui.nvim`

### `noconf.fnl`
- `numToStr/Comment.nvim` → `event = VeryLazy`
- `pwntester/octo.nvim` → `cmd = Octo`
- `smoka7/hop.nvim` → keys `s`, `S`
- `andymass/vim-matchup` → `event = [BufReadPost, BufNewFile]`
- `folke/todo-comments.nvim` → `event = [BufReadPost, BufNewFile]`
- `windwp/nvim-autopairs` → `event = InsertEnter`
- `yorickpeterse/nvim-pqf` → `event = VeryLazy`
- `Tyler-Barham/floating-help.nvim` → `cmd = FloatingHelp`
- `Bekaboo/dropbar.nvim` → `event = [BufReadPost, BufNewFile]`
- `ruifm/gitlinker.nvim` → key `<leader>gy` (n/v)
- `stevearc/oil.nvim` → `cmd = Oil`, key `-`
- `MeanderingProgrammer/render-markdown.nvim` → `ft = [markdown, Avante, codecompanion]`
- `stevearc/stickybuf.nvim` → `event = VeryLazy`
- `julienvincent/nvim-paredit` → `ft = [clojure, fennel, lisp, scheme]`
- `tpope/vim-fugitive` → git commands
- `tpope/vim-sleuth` → `event = [BufReadPost, BufNewFile]`
- `ThePrimeagen/vim-be-good` → `cmd = VimBeGood`
- `nvim-tree/nvim-web-devicons` → `lazy = true`
- `simrat39/symbols-outline.nvim` → `cmd = SymbolsOutline`
- `JellyApple102/flote.nvim` → `cmd = Flote`
- `HiPhish/rainbow-delimiters.nvim` → `event = [BufReadPost, BufNewFile]`
- `dstein64/vim-startuptime` → `cmd = StartupTime`
- `jbyuki/venn.nvim` → `cmd = VBox`
- `ActivityWatch/aw-watcher-vim` → `event = VeryLazy`
- `tpope/vim-eunuch` → file commands
- `HerringtonDarkholme/yats.vim` → `ft = [typescript, typescriptreact]`
- `tpope/vim-unimpaired` → keys `[` and `]`
- `rhysd/conflict-marker.vim` → `event = VeryLazy`

### `overseer.fnl`
- `stevearc/overseer.nvim`
  - Trigger: command set (`OverseerRun`, `OverseerToggle`, etc)

### `snacks.fnl`
- `folke/snacks.nvim`
  - Trigger: `event = VimEnter`, `priority = 1000`
  - Additional keys: `<leader>.`, `<leader>SS`

### `supermaven.fnl`
- `supermaven-inc/supermaven-nvim`
  - Trigger: `event = InsertEnter`
  - Dep: `saghen/blink.compat` (`lazy = true`)

### `telescope.fnl`
- `nvim-telescope/telescope.nvim`
  - Trigger: `event = VimEnter`
  - Deps: `plenary`, `telescope-fzf-native` (build `make`, cond), `telescope-ui-select`, `0xferrous/telescope-project.nvim`, `telescope-undo`

### `toggleterm.fnl`
- `akinsho/toggleterm.nvim`
  - Trigger: key `tt`
- `ryanmsnyder/toggleterm-manager.nvim`
  - Trigger: `lazy = true`
  - Deps: `akinsho/nvim-toggleterm.lua`, `telescope.nvim`, `plenary`

### `treesitter.fnl`
- `nvim-treesitter/nvim-treesitter`
  - Trigger: `event = [BufReadPost, BufNewFile]`
  - Build: `TSUpdate`
  - Deps: `nvim-treesitter-textobjects`

### `trouble.fnl`
- `folke/trouble.nvim`
  - Trigger: `cmd = Trouble`
  - Keys: `<leader>xx`, `<leader>xxe`, `<leader>xxw`, `<leader>xX`, `<leader>cs`, `<leader>cl`, `<leader>xL`, `<leader>xQ`

### `ufo.fnl`
- `kevinhwang91/nvim-ufo`
  - Trigger: keys `zR`, `zM`, `zr`, `zm`
  - Dep: `kevinhwang91/promise-async`

### `which-key.fnl`
- `folke/which-key.nvim`
  - Trigger: `event = VimEnter`

### `zk.fnl`
- `zk-org/zk-nvim`
  - Trigger: `lazy = true`
  - Keys: `<leader>zk*` command set
