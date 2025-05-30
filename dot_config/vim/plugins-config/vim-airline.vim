let g:airline_theme='catppuccin_mocha'

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#wordcount#enabled = 0

let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.executable = '⚙'
let g:airline_symbols.colnr = ' c:'
let g:airline_symbols.linenr = ' l:'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '󰘬'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_mode_map = {
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'n'      : 'N',
  \ 'R'      : 'R',
  \ 'v'      : 'V',
  \ 'V'      : 'V-L',
  \ }
