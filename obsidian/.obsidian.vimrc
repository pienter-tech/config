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
exmap revealFile obcommand file-explorer:reveal-active-file
nmap <Space>fv :toggleLeftSideBar<CR>
nmap <Space>gf :revealFile<CR>
