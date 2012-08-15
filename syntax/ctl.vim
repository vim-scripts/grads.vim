" Vim syntax file
" Language:	ctl (GrADS descriptor file)
" Maintainer:	Unicornio <unicornio@outlook.com>
" Last Change:	Aug 15, 2012
" Remark:

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

" Comments
syn match ctlComment "^\([\*#]\|@\s\).*$"

" Keywords
syn keyword ctlStatement
			\ dset chsub dtype index stnmap title undef unpack
			\ fileheader theader headerbytes trailerbytes xyheader
			\ xvar yvar zvar stid tvar toffvar cachesize options
			\ pdef xdef ydef zdef tdef edef endedef vectorpairs
			"\ vars endvars
"syn match ctlMetadata "\(@\s\)\@<=\<\h\w*\>"
syn keyword ctlKeywords
			\ bufr grib grib2 hdfsds hdf5_grid netcdf station
			\ pascals yrev zrev template sequential
			\ 365_day_calendar byteswapped big_endian little_endian
			\ cray_32bit_ieee linear levels gaust62 gausr15 gausr20
			\ gausr30 gausr40 names nps sps lccr lcc eta.u pse ops
			\ rotll rotllr bilin general file

" Right margin at column 79
"syn match gradsRightMargin ".\%>80v"

" Errors
syn match ctlError "\t"

" Numbers
syn match ctlNumber "\<\%([1-9]\d*\|0\)\>"
syn match ctlNumber "\<\d\+[eE][+-]\=\d\+\>"
syn match ctlFloat "\<\d\+\.\%([eE][+-]\=\d\+\)\=\%(\s\|$\)\@="
syn match ctlFloat "\([^\w]\)\@<=\d*\.\d\+\%([eE][+-]\=\d\+\)\=\>"

" Operator
syn match ctlOperator "\^" contained
syn match ctlNewvar "=>" contained
"syn match ctlMetaMark "@\s"

" Groups
syn match ctlTitle "\(\<title\>\)\@<=.*"
syn match ctlDset "\(\<dset\>\)\@<=.*" contains=ctlOperator
syn match ctlVarname "^\s*\<\h\w*\>" contained
syn match ctlNewvarname "\(=>\)\@<=\h\w*" contained
syn region ctlVars transparent matchgroup=ctlStatement
                        \ start="\<vars\>" end="\<endvars\>"
			\ contains=ctlNewvar,ctlNewvarname,ctlVarname,ctlNumber

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

	HiLink ctlComment		Comment
"	HiLink ctlStatement	Statement
	HiLink ctlStatement	Type
	HiLink ctlTitle		String
	HiLink ctlDset		Identifier
	HiLink ctlNumber		Number
	HiLink ctlFloat		Float
	HiLink ctlError		Error
	HiLink ctlOperator		Operator
"	HiLink ctlMetaMark		SpecialChar
"	HiLink ctlMetadata		Special
"	HiLink ctlKeywords		Type
	HiLink ctlKeywords		Statement
	HiLink ctlVarname		Identifier
	HiLink ctlNewvarname		Identifier
	HiLink ctlNewvar		Operator

"	HiLink gradsRightMargin		Error
"	highlight gradsRightMargin 	term=bold ctermfg=red guifg=red

	delcommand HiLink
endif

let b:current_syntax = "ctl"
" GrADS doesn't allow tabs
set expandtab
" sync
syn sync fromstart
