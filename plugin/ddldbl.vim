"{{{ File header information
"	vim:ff=unix ts=4 ss=4
"	vim60:fdm=marker
"
"	\file		ddldbl.vim
"
"	\brief		Delete Duplicate Lines and Delete Blank Lines.
"
"	\author		Robert KellyIV <Sreny@SverGbc.Pbz> (Rot13ed)
"	\date		Thu, 14 Nov 2002 23:04 Pacific Standard Time
"	\version	$Id: ddldbl.vim,v 1.1 2002/11/15 07:04:20 root Exp $
"	Version:	0.1
"	History: {{{
"	[Feral:318/02@21:45] 0.1
"		Initial
"	Improvments:
"		Added commands :DDL and :DBL
"		DDL is 'Delete Duplicate Lines' while dbl is 'Delete Blank
"			Lines'(lines containing only whitespace)
"		Both operate on a range of lines; defaulting to the entire file.
"	Limitations:
"		Does not save cursor position
"		Opens folds if there are any; At last check this was required else
"			commands operated on each line of the fold for as many lines of
"			the fold. Inconvient, but little more imho.
" }}}
"
"}}}

if exists("loaded_ddldbl")
	finish
endif
let loaded_ddldbl = 1

let s:save_cpo = &cpo
set cpo&vim


"*****************************************************************
" Functions: {{{
if !exists("*s:FeralDeleteDuplicateLines(...)")
function s:FeralDeleteDuplicateLines() range "{{{

	let Top_Line = a:firstline
	let End_Line = a:lastline
"	echo confirm(Top_Line.','.End_Line)

	silent! execute Top_Line.','.End_Line.'foldopen!'

	execute "normal! ".Top_Line.'G'
	while line('.') < End_Line
		let Cur_Line = line('.')
		let DaLine = '^'.escape(getline('.'), '\*^$.~').'$'
		while search(DaLine, 'W') != 0
			if line('.') <= End_Line
"				echo 'Deleting line('.line('.').'):'.getline('.')
				let End_Line = End_Line - 1
				delete
			else
"				echo 'found line is past our range; ignoring it and the rest of them'
				break
			endif
		endwhile
		execute "normal! ".Cur_Line.'G'
		normal! j
	endwhile

endfunction
"}}}
endif
" }}}

"*****************************************************************
" Commands: {{{
"*****************************************************************
if !exists(":DDL")
	" Delete Duplicate Lines
	command -range=% DDL		:<line1>,<line2>call <SID>FeralDeleteDuplicateLines()
endif

"[Feral:318/02@22:54] Just a hack because it is easy and logical.
if !exists(":DBL")
	" Delete Blank Lines
	command -range=% DBL		:<line1>,<line2>g/^\s*$/:delete
endif

"}}}
let &cpo = s:save_cpo
"EOF