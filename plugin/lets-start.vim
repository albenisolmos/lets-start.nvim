" prevent loading file twice
"if exists('g:loaded_lets_start') | finish | endif
"if exists('g:disable_lets_start') | finish | endif

if exists('g:loaded_lets_start') || exists('g:disable_lets_start')
	finish
endif
""	finish
""endif

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
	"nnoremap <buffer><silent> n :enew <bar> startinsert<CR>
	"nnoremap <buffer><silent> f :call ToggleExplore('fill')<CR>
	"nnoremap <buffer><silent> q :qa<cr>
endfun

function! s:on_init_vim()
	if argc() == 0
		"cnoremap <silent> q<CR> :call <SID>on_quit(0)<CR>
		let s:no_arguments = 1
	endif

	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	call s:start_page()
endfun
autocmd VimEnter * call s:on_init_vim()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_lest_start = 1
