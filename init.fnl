(local initlog (io.open :/tmp/nvim-init.log :w))
(fn initlog-msg [msg]
  (when initlog
    (initlog:write (.. (os.date "%H:%M:%S") " - " msg "\n"))
    (initlog:flush)))

(initlog-msg "=== INIT.FNL START ===")
(initlog-msg "Prepending compiled path")
(vim.opt.rtp:prepend (.. (vim.fn.stdpath :config) :/.compiled))
(initlog-msg "Enabling vim.loader")
(vim.loader.enable)
(initlog-msg "Requiring hotpot")
(require :hotpot)
(initlog-msg "Requiring cfg (main config)")
(require :cfg)
(initlog-msg "=== INIT.FNL COMPLETE ===")
(when initlog (initlog:close))
