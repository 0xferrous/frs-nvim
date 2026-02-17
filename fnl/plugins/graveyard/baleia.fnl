{1 :m00qek/baleia.nvim
 :enabled false
 :ft :ansi
 :config (fn []
           (set (. vim.g :baleia) ((. (require :baleia) :setup) {}))
           (vim.api.nvim_create_user_command :BaleiaColorize
                                             (fn []
                                               ((. (. vim.g :baleia) :once) (vim.api.nvim_get_current_buf)))
                                             {:bang true})
           (vim.api.nvim_create_user_command :BaleiaLogs
                                             (fn []
                                               ((. (. (. vim.g :baleia) :logger)
                                                   :show)))
                                             {:bang true})
           (when (= (. vim.bo :filetype) :ansi)
             (vim.cmd :BaleiaColorize))
           (vim.api.nvim_create_autocmd :BufEnter
                                        {:pattern :*.ansi
                                         :callback (fn []
                                                     (vim.cmd :BaleiaColorize))
                                         :desc "Auto-colorize ANSI files with Baleia"}))}
