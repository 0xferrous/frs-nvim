{1 :supermaven-inc/supermaven-nvim
 :event :InsertEnter
 :opts {:keymaps {:accept_suggestion :<S-Tab>
                  :clear_suggestion "<C-]>"
                  "accept_word:" :<C-j>}}
 :dependencies [{1 :saghen/blink.compat
                 :version "*"
                 :lazy true
                 :opts {:impersonate_nvim_cmp true :debug false}}]}
