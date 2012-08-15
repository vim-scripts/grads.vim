" Vim syntax file
" Language:	grads (GrADS scripts)
" Maintainer:	Unicornio <unicornio@outlook.com>
" Last Change:	Aug 15, 2012
" Remark:	Complete syntax

" Grid Analysis and Display System (GrADS); http://grads.iges.org/grads

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" GrADS is entirely case-insensitive.
syn case ignore

" Contains
syn match gradsCommand "\<ga->\s.\+$" contained
syn match gradsShell "\(\w\+\s*\)\@<!\!" contained
syn keyword gradsTodo TODO FIXME XXX contained
syn keyword gradsElse else contained
syn match gradsWeb "\<\(http://\|ftp://\|www\.\)[A-Za-z0-9_~]\+\([\./][A-Za-z0-9_~]*\)\+\>" contained
syn match gradsEmail "\<\w\+\(\.\w*\)*\(@\|\s*<at>\s*\)\w\+\(\.\w\+\)\+\>" contained

" Comments
syn match gradsComment "^[\*#].*$"
			\ contains=gradsTodo,gradsCommand,gradsWeb,gradsEmail

" Keywords
syn keyword gradsStatement exit return say print prompt pull read write close
syn match gradsFunction "\(\<function\>\)\@<=\s*\h\w*"
syn keyword gradsBuiltin
			\ subwrd sublin substr strlen wrdpos gsfallow gsfpath
			\ math_sin math_cos math_tan math_asin math_acos
			\ math_atan math_atan2 math_sinh math_cosh math_tanh
			\ math_asinh math_acosh math_atanh math_format
			\ math_nint math_int math_log math_log10 math_pow
			\ math_sqrt math_abs math_exp math_fmod math_mod
			\ math_strlen valnum

" Right margin at column 79
"syn match gradsRightMargin ".\%>80v"

" Errors
syn match gradsError "['\"()\[\]{}\t]"
syn match gradsError "\<endif\>\|\<endwhile\>\|\<else\>\|\<function\>"

" Blocks
syn cluster gradsNotNested
			\ contains=gradsFnBlk,gradsShell,gradsCommand,gradsTodo,gradsEmail,gradsWeb
syn region gradsIfBlk transparent matchgroup=gradsConditional
			\ start="\<if\>" end="\<endif\>"
			\ contains=ALLBUT,@gradsNotNested
syn region gradsWhileBlk transparent matchgroup=gradsRepeat
			\ start="\<while\>" end="\<endwhile\>"
			\ contains=ALLBUT,gradsElse,@gradsNotNested
syn region gradsFnBlk transparent matchgroup=gradsStatement
			\ start="\<function\>" skip="<\return\>"
			\ end="\<return\>"
			\ contains=ALLBUT,gradsElse,@gradsNotNested

" Strings and parenthesis
syn region gradsParent transparent matchgroup=Normal
			\ start="(" end=")" oneline
" ... Commenting one of two next lines will turn on/off the highlight of '':
"syn region gradsString
syn region gradsString matchgroup=Normal
			\ start=+'+ end=+'+ contains=gradsShell oneline
" ... Commenting one of two next lines will turn on/off the highlight of "":
"syn region gradsString
syn region gradsString matchgroup=Normal
			\ start=+"+ end=+"+ contains=gradsShell oneline

" Operator
syn match gradsOperator "|\|&\|!\(=\)\@!\|%"

" Errors for C programmers
syn match gradsError "&&\+\|||\+\|==\+"

" Numbers
syn match gradsNumber "\<\([1-9]\+\d*\|0\)\>"
syn match gradsNumber "\<\d\+[eE][+-]\=\d\+\>"
syn match gradsFloat "\(^\|\s\|-\)\@<=\.\d\+\([eE][+-]\=\d\+\)\="
syn match gradsFloat "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=\([^a-zA-Z_]\|$\)\@="

" Variables
syn keyword gradsFixVariables result rc
syn match gradsGlobalVariables "\<_\w\+\>"
syn match gradsCompVariables "\<\(\h\w*\.\(\w\+\.\)*\)\@<=\w\+\>"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't hgs highlighting+yet
if version >= 508 || !exists("did_gs_syn_inits")
	if version < 508
		let did_gs_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink gradsComment		Comment
	HiLink gradsTodo		Todo
	HiLink gradsCommand		SpecialComment
	HiLink gradsConditional		Conditional
	HiLink gradsElse		Conditional
	HiLink gradsRepeat		Repeat
	HiLink gradsStatement		Statement
	HiLink gradsFunction		Function
	HiLink gradsBuiltin		Function
	HiLink gradsString		String
	HiLink gradsNumber		Number
	HiLink gradsFloat		Float
	HiLink gradsFixVariables	Keyword
	HiLink gradsCompVariables	Identifier
	HiLink gradsGlobalVariables	Identifier
	HiLink gradsError		Error
	HiLink gradsShell		Delimiter
	HiLink gradsOperator		Operator
	HiLink gradsWeb			Underlined
	HiLink gradsEmail		Underlined

"	HiLink gradsRightMargin		Error
"	highlight gradsRightMargin 	term=bold ctermfg=red guifg=red

	delcommand HiLink
endif

let b:current_syntax = "grads"
" GrADS doesn't allow tabs
set expandtab
" sync
syn sync fromstart
