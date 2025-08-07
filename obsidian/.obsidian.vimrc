" set leader
unmap <Space>

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Yank to system clipboard
set clipboard=unnamed

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

" Search file
exmap searchFile obcommand global-search:open
nmap <Space>ff :searchFile<CR>

" Toggle left side bar
exmap toggleLeftSideBar obcommand app:toggle-left-sidebar
nmap <Space>fv :toggleLeftSideBar<CR>
exmap revealFile obcommand file-explorer:reveal-active-file
nmap <Space>gf :revealFile<CR>
exmap closeOthers obcommand workspace:close-others
nmap <Space>wo :closeOthers<CR>
exmap closeWindow obcommand workspace:close-window
nmap <Space>wc :closeWindow<CR>
exmap split obcommand workspace:split-vertical
nmap <Space>ws :split<CR>
exmap journalToday obcommand journals::open-today's-note
nmap <Space>jj :journalToday<CR>
exmap journalPrev obcommand journals:open-prev
nmap <Space>jp :journalPrev<CR>
exmap journalNext obcommand journals:open-next
nmap <Space>jn :journalNext<CR>
exmap journalMonth obcommand journals::open-monthly-note
nmap <Space>jm :journalMonth<CR>
exmap toggleTodo obcommand editor:toggle-checklist-status
nmap <Space>tt :toggleTodo<CR>
exmap followLink obcommand editor:follow-link
nmap <Enter> :followLink<CR>
exmap openContextMenu obcommand editor:context-menu
nmap <Space>1 :openContextMenu<CR>
vmap <Space>1 :openContextMenu<CR>

