" README {
" vim: set foldmarker={,} foldlevel=0 spell:
"
"	That's my personal .vimrc. As quite a lot of efforts went into this,
"	I would be glad if this was useful for anybody else than me.
"
"	And here it is on Github, although there seem to be thousands of
"	other great .vimrcs there:
"		https://github.com/flowm/vimrc
" }

" Basic {
		"Use Vim defaults
	set nocompatible
		"Pantogen is used to manage vim plugins
	call pathogen#infect()
	call pathogen#helptags()
	syntax enable
	filetype plugin indent on
		"Explicitly define xterm as environment
	behave xterm
		"More screen updates
	set ttyfast
		"No modeline for security
	set nomodeline
		"No exec
	set secure
		"Encoding
	"set encoding=utf-8
		"Function of the backspace key
	set backspace=indent,eol,start
" }

" General {
	" Backup and TMP Files {
		set backup
		set backupdir=~/.tmp/.vimbak
		set directory=~/.tmp/.vimtmp,.
		set history=2048
		set undolevels=2048
	" }
	" Tab completion {
		set wildmenu
		set wildmode=list:longest,list:full
		set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
	" }
	" Searching {
			"Highlightsearch
		set hlsearch
			"Start searching with the first Character
		set incsearch
			"Ignore Case
		set ignorecase
			"Match Case if searchstring starts with uppercase
		set smartcase
			"Global search by default
		set gdefault
			"Treat more Characters as special(like in perl) when searching (e.g. . *)
		set magic
	" }
	" Spelling {
		set spelllang=en_us,de_de
	" }
	" Misc {
		" Only one whitespace after _J_oining after a dot
		set nojoinspaces
	" }
" }

" Appearance and handling {
	" Theme {
		colorscheme evening
		set background=dark
	" }
	" Statusbar {
			"Show the Ruler (if statusbar isn't working)
		"set ruler
			"Renaming xterm window
		set title
			"Don't show line numbers
		set nonumber
			"Always show the status bar
		set laststatus=2
	" }
	" Statusline {
			"Clear the statusline
		set statusline=
			"Tail of the filename
		set statusline=%t\ 
			"Complete filename
		"set statusline=%f\ 
			"File format
		set statusline+=[%{&fileformat},
			"File encoding
		set statusline+=%{strlen(&fenc)?&fenc:&enc}]
			"Flag
		set statusline+=%m%r%h%w
			"Filetype
		set statusline+=[%Y]
			"Last modified
		set statusline+=%20(%{strftime(\"%d/%m/%y\ -\ %H:%M\")}%)
			"Left/Right separator
		set statusline+=%=
			"Current module name
		set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\ 
			"HEX value of char
		"set statusline+=[HEX:0x%2B]\ 
			"ASCII value of char
		"set statusline+=[ASCII:%3b]\ 
			"COL + LIN
		set statusline+=%-20([COL:%2v][LIN:%3l/%L]%)\ 
			"Percentage of file
		set statusline+=[%3p%%]
	" }
	" Misc Handling {
			"Always let 5 lines below and above the cursor on the screen
		set scroll=11
		set scrolloff=5
		set sidescroll=8
			"Bracket matching
		set showmatch
			"Show unfinished commands
		set showcmd
			"No Bell
		set noerrorbells visualbell
	" }
" }

" Text Formatting/Layout {
	" Whitespace and Tab display {
		set list
		set list listchars=tab:>.,trail:.
		"set list listchars=tab:>.,trail:�
	" }
	" Overlong lines display {
			"Break the line instead of scrolling right
		set wrap
			"Don't break lines
		set wrapmargin=0
			"But continue with a mark in the next line
		set showbreak=>>>
	" }
	" Indention {
			"One Tab per indentation level. 4 column wide Tabs.
			"Intelligently detect current indention level
		set smartindent
			"Size of real Tabs
		set tabstop=4
			"Indent amount when using TAB
		set softtabstop=4
			"Indent amount when using cindent, >>, ..
		set shiftwidth=4
			"Do not expand tabs to spaces
		set noexpandtab
	" }
	" Folding (disabled) {
			"Currently disable folding
		set nofoldenable
			"Make folding indent sensitive
		set foldmethod=manual
	" }
" }

" Mappings and functions {
	" Misc {
			"Easier escape
		inoremap <F1> <ESC>
		nnoremap <F1> <ESC>
		vnoremap <F1> <ESC>
		inoremap jj <ESC>
			"Match brackets key
		nnoremap <tab> %
		vnoremap <tab> %
			"Clear highlight
		map <silent> <C-l> :silent nohl<CR>
			"Save as root
		cmap w!! %!sudo tee > /dev/null %
	" }
	" Custom Keyset {
		let mapleader = ","
			"Reselect just pasted content
		nnoremap <leader>v V`]
			"Split Window and switch over to it
		nnoremap <leader>w <C-w>v<C-w>l
	" }
	" Disable arrow keys {
		nnoremap <up> <nop>
		nnoremap <down> <nop>
		nnoremap <left> <nop>
		nnoremap <right> <nop>
		inoremap <up> <nop>
		inoremap <down> <nop>
		inoremap <left> <nop>
		inoremap <right> <nop>
		nnoremap j gj
		nnoremap k gk
	" }
	" Syntax checking {
		map <leader>spl :w !perl -c %<CR>
		map <leader>srb :w !ruby -c %<CR>
		map <leader>sgcc :w !gcc -fsyntax-only %<CR>
		map <leader>sjava :w !javac %<CR>
	" }
	" <F4>-<F8> {
		" <F4> Toggle visual highlighting of lines onger than 80 chars {
			function ToggleColorColumn()
				if exists('+colorcolumn')
					if empty(&colorcolumn)
						if empty(&textwidth)
							set colorcolumn=81
						else
							set colorcolumn=+1
						endif
					else
						set colorcolumn=
					endif
				else
					if !exists('s:color_column')
						highlight OverLength ctermbg=red ctermfg=white guibg=#592929
						match OverLength /\%81v.\+/
						let s:color_column = 1
					else
						match OverLength //
						unlet s:color_column
					endif
				endif
			endfunction
			map <silent> <F4> :call ToggleColorColumn() <CR>
		" }
		" <F5> Toggle paste mode {
			set pastetoggle=<F5>
		" }
		" <F6> Toggle whitespace and tab display {
			function ToggleList()
				if &list
					set nolist
				else
					set list
				endif
			endfunction
			map <silent> <F6> :call ToggleList() <CR>
		" }
		" <F7> Toggle line numbers {
			function ToggleNumber()
				if &number
					set nonumber
				else
					set number
				endif
			endfunction
			map <silent> <F7> :call ToggleNumber() <CR>
		" }
		" <F8> Toggle spell checking {
			map <F8> :set spell!<CR><Bar>:echo 'Spell check: ' . strpart('OffOn', 3 * &spell, 3)<CR>
		" }
	" }
	" HTML encode all vowels with Strg-H {
		function HtmlEscape()
			silent s/�/\&ouml;/eg
			silent s/�/\&auml;/eg
			silent s/�/\&uuml;/eg
			silent s/�/\&Ouml;/eg
			silent s/�/\&Auml;/eg
			silent s/�/\&Uuml;/eg
			silent s/�/\&szlig;/eg
		endfunction
		map <silent> <c-h> :call HtmlEscape()<CR>
	" }
" }
" Settings for addons {
	let g:Perl_GlobalTemplateFile=$HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
" }

" Conditionals {
	if has('autocmd')
		" Ruby {
		au BufRead,BufNewFile *.rb,*.rhtml set tabstop=2
		au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
		au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
		au BufRead,BufNewFile *.rb,*.rhtml set expandtab
		"Deleting multible spaces at once
		au BufRead,BufNewFile *.rb,*.rhtml set smarttab
		" }
		" Perl {
		au BufRead,BufNewFile *.gui set ft=perl
		au BufRead,BufNewFile *.pl set tabstop=8
		au BufRead,BufNewFile *.pl set softtabstop=4
		au BufRead,BufNewFile *.pl set shiftwidth=4
		au BufRead,BufNewFile *.pl set noexpandtab
		au BufRead,BufNewFile *.pl set smarttab
		au BufRead,BufNewFile *.pl set shiftround
		" }
		" arduino {
		au BufRead,BufNewFile *.ino,*.pde set ft=arduino
		au BufRead,BufNewFile *.ino set tabstop=2
		au BufRead,BufNewFile *.ino set softtabstop=2
		au BufRead,BufNewFile *.ino set shiftwidth=2
		au BufRead,BufNewFile *.ino set expandtab
		" }
		" Other dev {
		au BufRead,BufNewFile *.README set textwidth=72
		au BufRead,BufNewFile *aegis-* set textwidth=72
		" }
	endif
" }

" To be tested/integrated {
	"set mouse=a
	"set confirm
	"au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
	"au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
	"au FocusLost * :wa
		"Column to mark overlong text
	"set colorcolumn=85
	"hi ColorColumn ctermbg=lightgrey guibg=lightgrey
" }
