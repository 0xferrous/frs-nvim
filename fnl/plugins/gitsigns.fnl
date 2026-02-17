(fn on_attach [bufnr]
  (local map vim.keymap.set)
  (local gitsigns (require :gitsigns))
  ;; Navigation
  (map :n "]c" (fn []
                 (if vim.wo.diff
                     (vim.cmd.normal {1 "]c" :bang true})
                     (gitsigns.nav_hunk :next)))
       {:desc "Jump to next git [c]hange" :buffer bufnr})
  (map :n "[c" (fn []
                 (if vim.wo.diff
                     (vim.cmd.normal {1 "[c" :bang true})
                     (gitsigns.nav_hunk :prev)))
       {:desc "Jump to previous git [c]hange" :buffer bufnr})
  ;; Actions
  ;; visual mode
  (map :v :<leader>hs
       (fn []
         (gitsigns.stage_hunk [(vim.fn.line ".") (vim.fn.line :v)]))
       {:desc "stage git hunk" :buffer bufnr})
  (map :v :<leader>hr
       (fn []
         (gitsigns.reset_hunk [(vim.fn.line ".") (vim.fn.line :v)]))
       {:desc "reset git hunk" :buffer bufnr})
  ;; normal mode
  (map :n :<leader>hs gitsigns.stage_hunk
       {:desc "git [s]tage hunk" :buffer bufnr})
  (map :n :<leader>hr gitsigns.reset_hunk
       {:desc "git [r]eset hunk" :buffer bufnr})
  (map :n :<leader>hS gitsigns.stage_buffer
       {:desc "git [S]tage buffer" :buffer bufnr})
  (map :n :<leader>hu gitsigns.undo_stage_hunk
       {:desc "git [u]ndo stage hunk" :buffer bufnr})
  (map :n :<leader>hR gitsigns.reset_buffer
       {:desc "git [R]eset buffer" :buffer bufnr})
  (map :n :<leader>hp gitsigns.preview_hunk
       {:desc "git [p]review hunk" :buffer bufnr})
  (map :n :<leader>hb gitsigns.blame_line
       {:desc "git [b]lame line" :buffer bufnr})
  (map :n :<leader>hd gitsigns.diffthis
       {:desc "git [d]iff against index" :buffer bufnr})
  (map :n :<leader>hD (fn []
                        (gitsigns.diffthis "@"))
       {:desc "git [D]iff against last commit" :buffer bufnr})
  ;; Toggles
  (map :n :<leader>tb gitsigns.toggle_current_line_blame
       {:desc "[T]oggle git show [b]lame line" :buffer bufnr})
  (map :n :<leader>tD gitsigns.toggle_deleted
       {:desc "[T]oggle git show [D]eleted" :buffer bufnr}))

{1 :lewis6991/gitsigns.nvim
 :event [:BufReadPre :BufNewFile]
 :opts {: on_attach :current_line_blame true}}
