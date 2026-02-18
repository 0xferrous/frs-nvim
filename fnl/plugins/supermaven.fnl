{1 :supermaven-inc/supermaven-nvim
 :event :InsertEnter
 :opts {:keymaps {:accept_suggestion :<S-Tab>
                  :clear_suggestion "<C-]>"
                  "accept_word:" :<C-j>}}
 :config (fn [opts]
           ; Supermaven plugin behavior:
           ; - supermaven-nvim expects an sm-agent binary in its own cache path
           ;   (computed by binary_fetcher:local_binary_path())
           ; - if that file is missing, the plugin downloads it at runtime via curl.
           ;
           ; This repo avoids runtime downloads by packaging sm-agent in flake.nix
           ; (extraPackages includes `supermaven-agent`, exposing `sm-agent` in PATH).
           ;
           ; At startup we:
           ; 1) resolve packaged sm-agent via :sm-agent on PATH,
           ; 2) compute Supermaven's expected local destination path,
           ; 3) copy packaged sm-agent there if missing,
           ; 4) chmod it executable.
           ;
           ; This keeps Supermaven operational while making the first-run behavior
           ; deterministic/offline-friendly.
           (let [fetcher (require :supermaven-nvim.binary.binary_fetcher)
                 dest (fetcher:local_binary_path)
                 parent (fetcher:local_binary_parent_path)
                 src (vim.fn.exepath :sm-agent)]
             (when (and (> (string.len src) 0)
                        (= (vim.fn.filereadable dest) 0))
               (vim.fn.mkdir parent :p)
               (vim.fn.system [:cp src dest])
               (vim.fn.system [:chmod :755 dest])))
           ((. (require :supermaven-nvim) :setup) opts.opts))
 :dependencies [{1 :saghen/blink.compat
                 :version "*"
                 :lazy true
                 :opts {:impersonate_nvim_cmp true :debug false}}]}
