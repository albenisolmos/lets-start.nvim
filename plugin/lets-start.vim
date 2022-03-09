" prevent loading file twice
if exists('g:loaded_lets_start') || exists('g:disable_lets_start')
	finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

function s:start_page()
	enew
	setlocal
				\ bufhidden=wipe
				\ buftype=nofile
				\ nobuflisted
				\ nocursorcolumn
				\ nocursorline
				\ nolist
				\ nonumber
				\ noswapfile
				\ norelativenumber
	lua require('lets-start').init()
	setlocal nomodifiable nomodified
endfun

function s:on_init_vim()
	if argc() == 0
		cnoremap <silent> q<CR> :call <SID>on_quit(0)<CR>
		call s:start_page()
	endif

	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	call s:start_page()
endfun
autocmd VimEnter * call s:on_init_vim()

function s:on_quit(write_file)
	if a:write_file
		if (expand('%:t')=="")
			echo "Can't save a file with no name."
			return
		endif
		write
	endif

	if (winnr('$')==1 && tabpagenr('$')==1)
		call s:start_page()
	else
		quit
	endif
endfun

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_lets_start = 1
