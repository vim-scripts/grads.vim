" GrADS indent file
" Language:	grads (Grads Scripts)
" Maintainer:	Unicornio <unicornio@outlook.com>
" Last Change:	Nov 13 2011
" Remark:	Modified Matlab file

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
	finish
endif

let b:did_indent = 1

" Some preliminary setting
setlocal indentkeys=~function,=~if,=~while,=~endif,=~endwhile,=~return,=~else,=*,=#
setlocal indentexpr=GetGradsIndent(v:lnum)

" Only define the function once.
if exists("*GetGradsIndent")
	finish
endif


function GetGradsIndent(lnum)
	" Give up if this line is explicitly joined.
	if getline(a:lnum - 1) =~ '\\$'
		return -1
	endif

	" Search backwards for the first non-empty line, ignoring comments.
	let plnum = a:lnum - 1
	while plnum > 0 && getline(plnum) =~ '^\(#\|\*\|\s*$\)'
		let plnum = plnum - 1
	endwhile

	if plnum == 0 || getline(v:lnum) =~ '^\s*\(\*\|#\)'
		" If commented or first non-empty line, use zero indent.
		return 0
	endif

	let curind = indent(plnum)

	if getline(plnum) =~ '^\s*\(if\|while\|function\|else\)\>'
		" look if the statement only places one line
		if getline(plnum) =~ '^.*\<\(endif\|endwhile\|return\)\(;*\s*\)*$'
			let curind = curind
		else
			let curind = curind + &sw
		endif
	endif
	if getline(v:lnum) =~ '^\s*\<\(endif\|endwhile\|return\|else\)\>'
		" closing block, reduce indentation
		let curind = curind - &sw
	endif

	" If we got to here, it means that the user takes the standardversion, so we return it
	return curind
endfunction
