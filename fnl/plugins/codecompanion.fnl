(fn keymap [lhs rhs desc]
  {1 lhs 2 rhs :mode [:n :v] :noremap true :silent true : desc})

[{1 :olimorris/codecompanion.nvim
  :keys [(keymap :<leader>cca :<cmd>CodeCompanionActions<cr> "Open cc actions")
         (keymap :<LocalLeader>a "<cmd>CodeCompanionChat Toggle<cr>"
                 "Toggle cc chat")
         (keymap :ga "<cmd>CodeCompanionChat Add<cr>"
                 "Add selected code to cc chat")]
  :config (fn []
            (vim.cmd "cab cc CodeCompanion")
            (let [cc (require :codecompanion)
                  cca (require :codecompanion.adapters)]
              (cc.setup {:display {:action_palette {:provider :telescope}
                                   :diff {:provider :mini_diff}}
                         :interactions {:chat {:adapter :claude_code
                                               :roles {:llm (fn [adapter]
                                                              (.. "CodeCompanion ("
                                                                  adapter.formatted_name
                                                                  ")"))}
                                               :tools {:mcp {:callback (fn []
                                                                         (require :mcphub.extensions.codecompanion))
                                                             :description "Call tools and resources from MCP servers"}}}
                                        :inline {:adapter :openrouter}}
                         :adapters {:http {:ollama (fn []
                                                     (cca.extend :ollama
                                                                 {:env {:url "http://localhost:11434"}}))
                                           :openrouter (fn []
                                                         (cca.extend :openai_compatible
                                                                     {:env {:api_key (os.getenv "OPENROUTER_API_KEY")}
                                                                      :schema {:model {:default :google/gemini-2.5-flash}}}))
                                           :gemini (fn []
                                                     (cca.extend :gemini
                                                                 {:env {:api_key (os.getenv "GEMINI_API_KEY")}}))}
                                    :acp {:claude_code (fn []
                                                         (cca.extend :claude_code
                                                                     {:env {:CLAUDE_CODE_OAUTH_TOKEN "cmd: jq -r .claudeAiOauth.accessToken ~/.claude/.credentials.json"}}))}}
                         :opts {:log_level :ERROR}})
              (let [ccf (require :cfg.code_companion_fidget)
                    telescope (require :telescope)]
                (ccf:init)
                (telescope.load_extension :codecompanion))))
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-treesitter/nvim-treesitter
                 :j-hui/fidget.nvim
                 {1 :echasnovski/mini.diff
                  :config (fn []
                            (let [diff (require :mini.diff)]
                              (diff.setup {:source (diff.gen_source.none)})))}
                 :nvim-telescope/telescope.nvim]}
 {1 :ravitemer/mcphub.nvim
  :dependencies {1 :nvim-lua/plenary.nvim}
  :cmd :MCPHub
  :opts {:extensions {:codecompanion {:show_result_in_chat false}}}}]
