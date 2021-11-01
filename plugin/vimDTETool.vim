if exists('g:vimDTETool')
  finish
endif
let g:vimDTETool=1
let s:save_cpo = &cpo
function! VSAttach(cmd)
	execute 'term ++hidden DTETool AttachProcess ' . a:cmd
endfunction
function! VSCmd(cmd)
	execute 'term ++hidden DTETool ' . a:cmd
endfunction
function! VSFile(cmd)
	execute 'term ++hidden DTETool ' . a:cmd . ' "'. expand('%:p') . '" ' . line('.') . ' ' . col('.')
endfunction
function! MySln(targetpath)
	let dirname = fnamemodify(a:targetpath, ':h')
	let sln = glob(dirname . '/*.sln')
	if sln != ''
		call system(sln)
	endif
	if dirname != a:targetpath
		call OpenSln(dirname)
	endif
endfunction
command! OpenSln OpenMySln(expand('%:p:h'))
command! VSOpen call VSFile('OpenFile')
command! VSBreakPoint call VSFile('BreakPoint')
command! VSDeleteBreakPoint call VSCmd('DeleteBreakPoint')
command! VSAttachUnity call VSAttach('Unity.exe')
command! VSDetachProcess call VSCmd('DetachProcess')
let &cpo = s:save_cpo
unlet s:save_cpo
