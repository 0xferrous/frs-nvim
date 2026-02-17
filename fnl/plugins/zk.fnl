{1 :zk-org/zk-nvim
 :opts {:picker :snacks_picker}
 :lazy true
 :keys [{1 :<leader>zke 2 :<cmd>ZkNotes<cr> :desc "zk notes"}
        {1 :<leader>zkn 2 :<cmd>ZkNew<cr> :desc "creates and edits a new note"}
        {1 :<leader>zknt
         2 "<cmd>'<,'>ZkNewFromTitleSelection<cr>"
         :desc "creates a new note(used as title) from visual selection"}
        {1 :<leader>zknc
         2 "<cmd>'<,'>ZkNewFromContentSelection<cr>"
         :desc "creates a new note(used as content) from visual selection"}
        {1 :<leader>zkb
         2 :<cmd>ZkBuffers<cr>
         :desc "note picker for active zk notes buffers"}
        {1 :<leader>zkB
         2 :<cmd>ZkBacklinks<cr>
         :desc "note picker for backlinks of current note"}
        {1 :<leader>zkl
         2 :<cmd>ZkLinks<cr>
         :desc "note picker for links of current note"}
        {1 :<leader>zki
         2 :<cmd>ZkInsertLink<cr>
         :desc "inserts a link at the cursor"}
        {1 :<leader>zkI
         2 ":<cmd>'<,'>ZkInsertLinkAtSelection<cr>"
         :desc "inserts a link around the selected text"}
        {1 :<leader>zkd
         2 (fn []
             (let [zk (require :zk)]
               (zk.new {:dir :journal/daily})))
         :desc "creates a new daily note"}]}
