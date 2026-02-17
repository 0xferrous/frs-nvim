; Debug logging setup
(local logfile (io.open :/tmp/nvim-startup.log :w))
(fn log [msg]
  (when logfile
    (logfile:write (.. (os.date "%H:%M:%S") " - " msg " - Mem: "
                       (/ (collectgarbage :count) 1024) " MB\n"))
    (logfile:flush)))

(log "=== NVIM STARTUP BEGIN ===")

; Set <space> as the leader key
(set vim.g.mapleader " ")
(set vim.g.maplocalleader " ")
(vim.keymap.set [:n :v] :<Space> :<Nop> {:silent true})
(log "Leader keys set")

; (set vim.opt.shell :/run/current-system/sw/bin/nu)

;; set neovim options
; set the floating window borders
(set vim.o.winborder :rounded)

; set highlight on search
(set vim.o.hlsearch false)

; make line numbers default
(set vim.wo.number true)
(set vim.wo.relativenumber true)

; enable mouse mode
(set vim.o.mouse :a)

; sync clipboard between OS and Neovim.
(set vim.o.clipboard :unnamedplus)

; enable break ident
(set vim.o.breakindent true)

; save undo history
(set vim.o.undofile true)

; case-insensitive searching UNLESS \C or capital in search
(set vim.o.ignorecase true)
(set vim.o.smartcase true)

; keep signcolumn on by default
(set vim.wo.signcolumn :yes)

; decrease update time
(set vim.o.updatetime 250)
(set vim.o.timeoutlen 300)

; configure how new splits should be opened
(set vim.opt.splitright true)
(set vim.opt.splitbelow true)

; preview substitutions live, as you type!
(set vim.opt.inccommand :split)

; set completeopt to have a better completion experience
(set vim.o.completeopt "menuone,noselect")

; show trailing whitespace and render tabs with full width
(set vim.opt.list true)
(set vim.opt.listchars {:trail "·" :tab "»·"})

;; remap for dealing with word wrap
(vim.keymap.set :n :k "v:count == 0 ? 'gk' : 'k'" {:expr true :silent true})
(vim.keymap.set :n :j "v:count == 0 ? 'gj' : 'j'" {:expr true :silent true})

;; highlight on yank
(vim.api.nvim_create_autocmd :TextYankPost
                             {:desc "Highlight when yanking (copying) text"
                              :group (vim.api.nvim_create_augroup :highlight-yank
                                                                  {:clear true})
                              :callback vim.highlight.on_yank})

(log "Autocmds created")

;; diagnostic keymaps
(vim.keymap.set :n :<leader>e vim.diagnostic.open_float
                {:desc "Open floating diagnostic message"})

(vim.keymap.set :n :<leader>q vim.diagnostic.setloclist
                {:desc "Open diagnostics list"})

;; terminal to normal mode keymap
(vim.keymap.set :t :<Esc><Esc> "<C-\\><C-n>" {:desc "enter select mode"})

;; neovide macos stuff
; (when (vim.g.neovide?)
;   (vim.keymap.set :v :<D-c> "\"+y")
;   (vim.keymap.set :n :<D-v> "\"+P")
;   (vim.keymap.set :v :<D-v> "\"+P")
;   (vim.keymap.set :c :<D-v> "<C-R>+")
;   (vim.keymap.set :i :<D-v> "<ESC>\"+Pli"))

;; no zellij auto start
(set vim.env.ZELLIJ 0)

;; highlight active line
(set vim.go.cursorline true)

;; set filetype for .ansi files
(vim.api.nvim_create_autocmd [:BufRead :BufNewFile]
                             {:pattern :*.ansi
                              :callback (fn [] (set vim.bo.filetype :ansi))
                              :desc "set filetype to ansi for .ansi files"})

;; Render ANSI codes in current buffer
(vim.api.nvim_create_user_command :TermHl
                                  (fn []
                                    (let [b (vim.api.nvim_create_buf false true)
                                          chan (vim.api.nvim_open_term b {})]
                                      (vim.api.nvim_chan_send chan
                                                              (table.concat (vim.api.nvim_buf_get_lines 0
                                                                                                        0
                                                                                                        -1
                                                                                                        false)
                                                                            "\n"))
                                      (vim.api.nvim_win_set_buf 0 b)))
                                  {:desc "Highlights ANSI termcodes in curbuf"})

; setup plugins via nix-provided runtime paths (no runtime package manager)
(log "Before requiring nix plugin loader")
(let [loader (require :cfg.fns)]
  (log "Nix loader required, starting setup")
  (loader.setup_nix_plugins)
  (log "Nix loader setup complete"))

;; colorscheme
(log "Setting colorscheme")
(vim.cmd.colorscheme :gruvbox-material)
(log "Colorscheme set")

; neovide config
(set vim.g.neovide_opacity 0.95)
(set vim.g.neovide_normal_opacity 0.95)
(set vim.g.neovide_theme :dark)

; (when vim.g.neovide?
;   (vim.keymap.set [:n :i :t] :<C-Tab> :<cmd>tabnext<cr> {:desc "next tab"})
;   (vim.keymap.set [:n :i :t] :<C-S-Tab> :<cmd>tabprev<cr> {:desc "prev tab"}))

(log "=== NVIM STARTUP COMPLETE ===")
(when logfile (logfile:close))
