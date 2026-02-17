(local string string)
(local table table)
(local math math)

(fn theme_config []
  (let [theme (require :alpha.themes.startify)
        section theme.section
        button theme.button
        session {:type :group
                 :val [{:type :padding :val 1}
                       {:type :text
                        :val "Sessions MRU"
                        :opts {:hl :SpecialComment}}
                       {:type :padding :val 1}
                       {:type :group
                        :val (fn []
                               (let [auto_session (require :auto-session)
                                     cwd (auto_session.get_root_dir)
                                     all_sessions (vim.fs.find (fn [_ _] true)
                                                               {:path cwd
                                                                :limit math.huge})
                                     sessions_with_mtimes []]
                                 (each [_ session (ipairs all_sessions)]
                                   (let [stat (vim.uv.fs_stat session)]
                                     (when stat
                                       (table.insert sessions_with_mtimes
                                                     {:mtime stat.mtime
                                                      : session}))))
                                 (table.sort sessions_with_mtimes
                                             (fn [a b]
                                               (if (= a.mtime.sec b.mtime.sec)
                                                   (>= a.mtime.nsec
                                                       b.mtime.nsec)
                                                   (>= a.mtime.sec b.mtime.sec))))
                                 (let [results []
                                       max_sessions 10
                                       total (length sessions_with_mtimes)]
                                   (var i 1)
                                   (while (and (<= i total) (<= i max_sessions))
                                     (let [session_mtime (. sessions_with_mtimes
                                                            i)
                                           session_name (vim.fs.basename session_mtime.session)
                                           display (select 1
                                                           (string.gsub session_name
                                                                        "%%" "/"))
                                           path session_mtime.session]
                                       (table.insert results
                                                     {:type :button
                                                      :val display
                                                      :on_press (fn []
                                                                  (auto_session.RestoreSession path))}))
                                     (set i (+ i 1)))
                                   results)))}]}
        top_buttons {:type :group
                     :val [(button :e "New file" "<cmd>ene <CR>")
                           (button :s "Current directory session"
                                   :<cmd>SessionRestore<CR>)]}]
    {:layout [{:type :padding :val 1}
              section.header
              {:type :padding :val 2}
              top_buttons
              session
              {:type :padding :val 1}
              section.mru_cwd
              section.mru
              {:type :padding :val 1}
              section.bottom_buttons
              section.footer]
     :opts {:margin 3
            :redraw_on_resize false
            :setup (fn []
                     (vim.api.nvim_create_autocmd :DirChanged
                                                  {:pattern "*"
                                                   :group :alpha_temp
                                                   :callback (fn []
                                                               ((. (require :alpha)
                                                                   :redraw))
                                                               (vim.cmd :AlphaRemap))}))}}))

[{1 :goolord/alpha-nvim
  :enabled false
  :config (fn []
            (let [opts (theme_config)]
              ((. (require :alpha) :setup) opts)))
  :dependencies [:rmagatti/auto-session]}]
