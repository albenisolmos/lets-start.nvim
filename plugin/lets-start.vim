" prevent loading file twice
if exists('g:loaded_lets_start') || 
	exists('g:disable_lets_start')
	finish
endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! LetsStart lua require('lets-start').init()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_lest_start = 1
